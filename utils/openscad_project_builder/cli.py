# Python tool that "builds" an openscad project

import click
import sys
from loguru import logger
from osbuild.project import Project
from pathlib import Path

logger.remove()
logger.add(sys.stderr, level="INFO")


@click.group()
def cli():
    pass


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
def build(project_dir, selected_file_patterns):
    project = Project(Path(project_dir), selected_file_patterns)
    project.parse_config()
    project.compile()
    project.build()


if __name__ == "__main__":
    cli()
