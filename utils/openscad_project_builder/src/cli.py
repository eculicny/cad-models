# Python tool that "builds" an openscad project

import sys
from pathlib import Path

import click
from loguru import logger
from osbuild.project import Project

logger.remove()
logger.add(sys.stderr, level="INFO")


@click.group()
@click.option("--debug", is_flag=True, help="Enable debug logging")
def cli(debug):
    if debug:
        logger.remove()
        logger.add(sys.stderr, level="DEBUG")


# @cli.command()
# def compile():
#     project = Project(project_dir, selected_file_patterns=[])
#     project.parse_config()
#     project.compile()


@cli.command()
@click.argument("project_dir", type=click.Path(file_okay=False, dir_okay=True))
@click.option(
    "--selected_file_patterns",
    "-s",
    multiple=True,
    help="Glob patterns for files to include in the build",
)
@click.option("--repair-mesh", is_flag=True)
def build(project_dir, selected_file_patterns, repair_mesh):
    project = Project(Path(project_dir), selected_file_patterns)
    project.parse_config()
    project.compile()
    project.build(repair_mesh=repair_mesh)


if __name__ == "__main__":
    cli()
