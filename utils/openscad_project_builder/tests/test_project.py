from __future__ import annotations

import subprocess
from pathlib import Path

import pytest

from osbuild.project import Project


def test_parse_config_sets_ignore_parser(tmp_path: Path):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    config = project_dir / "osbuild.toml"
    config.write_text("""
[config]
ignore_files = ["tests/**", "*.tmp"]
""")

    project = Project(project_dir, selected_file_patterns=[])
    project.parse_config()

    assert project.ignore_parser is not None
    assert project.ignore_parser.match(project_dir / "tests" / "example.scad")
    assert project.ignore_parser.match(project_dir / "example.tmp")


def test_compile_identifies_scad_and_py_files(tmp_path: Path):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    config = project_dir / "osbuild.toml"
    config.write_text("""
[config]
ignore_files = ["ignore.scad"]
""")

    scad_file = project_dir / "example.scad"
    scad_file.write_text('echo("hello");')
    py_file = project_dir / "example.py"
    py_file.write_text('BUILD_PARAMETERS = [{"output_suffix": "v1", "option": 42}]\n')
    ignored_file = project_dir / "ignore.scad"
    ignored_file.write_text('echo("ignore");')

    project = Project(project_dir, selected_file_patterns=[])
    project.parse_config()
    project.compile()

    assert project.scad_files == []
    assert project.config_files == [py_file]


def test_compile_ignores_stl_when_same_stem_py_and_scad_exist(tmp_path: Path):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    config = project_dir / "osbuild.toml"
    config.write_text("""
[config]
ignore_files = []
""")

    scad_file = project_dir / "example.scad"
    scad_file.write_text('echo("hello");')
    py_file = project_dir / "example.py"
    py_file.write_text('BUILD_PARAMETERS = [{"output_suffix": "v1", "option": 42}]\n')
    stl_file = project_dir / "example.stl"
    stl_file.write_text("binary content")

    project = Project(project_dir, selected_file_patterns=[])
    project.parse_config()
    project.compile()

    assert project.scad_files == []
    assert project.config_files == [py_file]


def test_compile_respects_selected_file_patterns(tmp_path: Path):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    config = project_dir / "osbuild.toml"
    config.write_text("""
[config]
ignore_files = []
""")

    included_scad = project_dir / "included.scad"
    included_scad.write_text('echo("in");')
    excluded_scad = project_dir / "excluded.scad"
    excluded_scad.write_text('echo("out");')

    project = Project(project_dir, selected_file_patterns=["included.scad"])
    project.parse_config()
    project.compile()

    assert project.scad_files == [included_scad]
    assert excluded_scad not in project.scad_files
    assert project.config_files == []


def test_compile_respects_nested_selected_file_patterns(tmp_path: Path):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    config = project_dir / "osbuild.toml"
    config.write_text("""
[config]
ignore_files = []
""")

    included_scad = project_dir / "subdir" / "nested" / "included.scad"
    included_scad.parent.mkdir(parents=True)
    included_scad.write_text('echo("nested include");')

    excluded_scad = project_dir / "subdir" / "nested" / "excluded.scad"
    excluded_scad.write_text('echo("nested exclude");')
    other_scad = project_dir / "other.scad"
    other_scad.write_text('echo("other");')

    project = Project(
        project_dir, selected_file_patterns=["subdir/nested/included.scad"]
    )
    project.parse_config()
    project.compile()

    assert project.scad_files == [included_scad]
    assert excluded_scad not in project.scad_files
    assert other_scad not in project.scad_files
    assert project.config_files == []


def test_compile_respects_ignored_subdirectory_patterns(tmp_path: Path):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    config = project_dir / "osbuild.toml"
    config.write_text("""
[config]
ignore_files = ["subdir/nested/**"]
""")

    ignored_scad = project_dir / "subdir" / "nested" / "ignored.scad"
    ignored_scad.parent.mkdir(parents=True)
    ignored_scad.write_text('echo("ignored");')

    included_scad = project_dir / "subdir" / "other" / "included.scad"
    included_scad.parent.mkdir(parents=True)
    included_scad.write_text('echo("included");')

    project = Project(project_dir, selected_file_patterns=[])
    project.parse_config()
    project.compile()

    assert ignored_scad not in project.scad_files
    assert included_scad in project.scad_files
    assert project.config_files == []


def test_build_processes_parameterized_py_config(tmp_path: Path, monkeypatch):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    config = project_dir / "osbuild.toml"
    config.write_text("""
[config]
ignore_files = []
""")

    scad_file = project_dir / "example.scad"
    scad_file.write_text('echo("parameterized");')
    py_file = project_dir / "example.py"
    py_file.write_text(
        "BUILD_PARAMETERS = [\n"
        '    {"output_suffix": "v1", "output_subdir": "param", "size": 10},\n'
        '    {"output_suffix": "v2", "size": 20},\n'
        "]\n"
    )

    project = Project(project_dir, selected_file_patterns=[])
    project.parse_config()
    project.compile()

    calls = []

    def fake_execute(
        input_file,
        output_file=None,
        parameters=None,
        format="binstl",
        output_suffix="",
        output_subdir=None,
    ):
        calls.append(
            {
                "input_file": input_file,
                "parameters": dict(parameters) if parameters is not None else {},
                "output_suffix": output_suffix,
                "output_subdir": output_subdir,
            }
        )
        return True

    monkeypatch.setattr(project, "_execute_openscad_cli", fake_execute)
    project.build()

    assert project.build_dir.exists()
    assert len(calls) == 2
    assert calls[0]["input_file"] == project_dir / "example.scad"
    assert calls[0]["parameters"] == {"size": 10}
    assert calls[0]["output_suffix"] == "v1"
    assert calls[0]["output_subdir"] == "param"
    assert calls[1]["parameters"] == {"size": 20}
    assert calls[1]["output_suffix"] == "v2"
    assert calls[1]["output_subdir"] is None


def test_generate_build_path_with_suffix_and_subdir(tmp_path: Path):
    project_dir = tmp_path / "project"
    project_dir.mkdir()
    project = Project(project_dir, selected_file_patterns=[])

    scad_file = project_dir / "subdir" / "example.scad"
    scad_file.parent.mkdir(parents=True)
    build_path = project._generate_build_path(
        scad_file, build_suffix="v2", build_subdir=Path("export")
    )

    assert build_path == project_dir / "build" / "subdir" / "export" / "example_v2.stl"


def test_openscad_cli_quote_handles_strings_and_non_strings(tmp_path: Path):
    project = Project(tmp_path, selected_file_patterns=[])

    assert project._openscad_cli_quote("hello world") == '"\\"hello world\\""'
    assert project._openscad_cli_quote(42) == 42


def test_execute_openscad_cli_runs_command(tmp_path: Path, monkeypatch):
    project = Project(tmp_path, selected_file_patterns=[])
    scad_file = tmp_path / "example.scad"
    scad_file.write_text('echo("hi");')

    captured = {}

    class FakeCompletedProcess:
        def __init__(self):
            self.returncode = 0
            self.stdout = b"ok"
            self.stderr = b""

    def fake_run(command, shell, stdout, stderr):
        captured["command"] = command
        return FakeCompletedProcess()

    monkeypatch.setattr(subprocess, "run", fake_run)
    success = project._execute_openscad_cli(scad_file)

    assert success
    assert "openscad --backend Manifold" in captured["command"]
    assert str(scad_file) in captured["command"]
