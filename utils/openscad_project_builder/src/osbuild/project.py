import tomllib
import igittigitt
import shutil
import subprocess
from pathlib import Path
from loguru import logger


class Project:
    def __init__(self, project_dir: Path, selected_file_patterns: list[str]):
        self.project_dir = project_dir
        self.project_config = self.project_dir / "osbuild.toml"
        self.build_dir = self.project_dir / "build"
        self.build_log = self.build_dir / "build.log"
        self.scad_files = []
        self.config_files = []
        self.selected_file_patterns = selected_file_patterns
        self.include_parser = None
        self.ignore_parser = None

    def parse_config(self):
        """
        Loads the project config file and parses the ignored files glob pattern list
        """
        conf = tomllib.loads(self.project_config.read_text())
        ignore_parser = igittigitt.IgnoreParser()
        # default rules
        ignore_parser.add_rule("osbuild.toml", base_path=self.project_dir)
        ignore_parser.add_rule("build/", base_path=self.project_dir)
        # config rules
        for pattern in conf.get("config", {}).get("ignore_files", []):
            ignore_parser.add_rule(pattern, base_path=self.project_dir)
        self.ignore_parser = ignore_parser

        # include rules if provided
        if self.selected_file_patterns:
            include_parser = igittigitt.IncludeParser()
            for pattern in self.selected_file_patterns:
                include_parser.add_rule(pattern, base_path=self.project_dir)
            self.include_parser = include_parser

    def compile(self):
        """
        Compiles an openscad project directory by loading the toml config file and recursively walking through
        the project directory to find .scad files that are not excluded in the glob pattern ignored files list from the project config

        If there exist two files with the same name stem but a .scad and .py extension, the .py file is assumed to be a parameterized config file for the .scad file.
        The .scad file will be ignored and the .py file will be added to a config file list for processing during the project build.
        """
        logger.info(
            f"Compiling project {self.project_dir} with config file {self.project_config}"
        )

        for root, dirs, files in self.project_dir.walk():
            logger.debug(f"Current Directory object: {root}")
            logger.debug(f"Subdirectories found: {dirs}")
            file_stems = {}
            for f in files:
                if self.include_parser and not self.include_parser.match(root / f):
                    logger.info(f"Excluding file: {root / f}")
                    continue
                elif self.ignore_parser.match(root / f):
                    logger.info(f"Ignoring file: {root / f}")
                    continue
                else:
                    file_stems[(root / f).stem] = file_stems.get(
                        (root / f).stem, []
                    ) + [(root / f)]

            for fs, file_list in file_stems.items():
                if (
                    len(file_list) == 2
                    and any(f.suffix == ".scad" for f in file_list)
                    and any(f.suffix == ".py" for f in file_list)
                ):
                    logger.info(
                        f"Found parameterized config file for {fs}.scad, ignoring .scad file and adding .py file to config list"
                    )
                    self.config_files.append(root / (fs + ".py"))
                elif any(f.suffix == ".scad" for f in file_list):
                    logger.info(f"Found .scad file: {fs}.scad")
                    self.scad_files.append(root / (fs + ".scad"))
                else:
                    logger.warning(
                        f"Too many or no .scad or .py file found for {fs}, ignoring"
                    )

    def build(self):
        """
        Builds the project by creating stl files from the .scad files found in the project directory and placing them in the build directory.

        Any .py config files have their parameters loaded and converted to CLI arguments for the openscad command line tool to generate the .stl files.

        All subprocess output is piped to stdout and logged to the build.log file in the build directory.
        """
        logger.info(
            f"Building project {self.project_dir} with {len(self.scad_files)} .scad files and {len(self.config_files)} config files"
        )

        # clear the build directory before building
        if not self.selected_file_patterns:
            logger.info(
                f"Clearing build directory {self.build_dir} for full project build"
            )
            shutil.rmtree(self.build_dir, ignore_errors=True)
        self.build_dir.mkdir(exist_ok=True)
        # attach handler for build log
        build_log_handler_id = logger.add(self.build_log, level="DEBUG")
        has_build_error = False

        # process scad files
        for scad_file in self.scad_files:
            logger.info(f"Building .scad file: {scad_file}")
            command_success = self._execute_openscad_cli(scad_file)
            has_build_error = has_build_error or not command_success

        # process config files
        for config_file in self.config_files:
            logger.info(f"Processing config file: {config_file}")
            # load the config file and extract the parameters
            config = {}
            exec(config_file.read_text(), {}, config)

            file_build_configs = config.get("BUILD_PARAMETERS")
            if not file_build_configs:
                logger.warning(
                    f"No BUILD_PARAMETERS found in {config_file}, skipping. Consider adding to ignore list."
                )
                continue
            # TODO switch to config objects
            if not all(isinstance(c, dict) for c in file_build_configs):
                logger.error(
                    f"Invalid build configurations found in {config_file}, skipping."
                )
                has_build_error = True
                continue

            logger.info(
                f"Found {len(file_build_configs)} build configurations in {config_file}"
            )

            for file_config in file_build_configs:
                output_suffix = file_config.pop("output_suffix")
                output_subdir = file_config.pop("output_subdir", None)
                command_success = self._execute_openscad_cli(
                    config_file.with_suffix(".scad"),
                    parameters=file_config,
                    output_suffix=output_suffix,
                    output_subdir=output_subdir,
                )
                has_build_error = has_build_error or not command_success

        # remove build log handler
        logger.remove(build_log_handler_id)

        if has_build_error:
            logger.error(
                f"Build of {self.project_dir}{self.selected_file_patterns if self.selected_file_patterns else ''} completed with errors. See log for details."
            )
        else:
            logger.info(
                f"Build of {self.project_dir}{self.selected_file_patterns if self.selected_file_patterns else ''} completed successfully."
            )

    def _generate_build_path(
        self, scad_file: Path, build_suffix: str, build_subdir: Path | None
    ):
        """
        Generates the build path for a given .scad file based on the project directory structure.
        """
        relative_path = scad_file.relative_to(self.project_dir)
        build_path = self.build_dir / relative_path.parent
        if build_suffix and build_suffix[0] != "_":
            build_suffix = "_" + build_suffix

        if build_subdir:
            build_path = build_path / build_subdir

        stl_file = build_path / (scad_file.stem + build_suffix + ".stl")
        return stl_file

    def _openscad_cli_quote(self, s: object) -> object:
        if isinstance(s, str):
            return f'"\\"{s}\\""'
        return s

    def _execute_openscad_cli(
        self,
        input_file: Path,
        output_file: Path | None = None,
        parameters: dict = {},
        format: str = "binstl",
        output_suffix: str = "",
        output_subdir: Path | None = None,
    ):
        """
        Executes the openscad command line tool with the given command string and logs the output to the build.log file.
        """
        output_file = output_file or self._generate_build_path(
            input_file, build_suffix=output_suffix, build_subdir=output_subdir
        )
        if not output_file.parent.exists():
            logger.debug(f"Creating output directory: {output_file.parent}")
            output_file.parent.mkdir(parents=True)
        cli_params = " ".join(
            [f"-D {k}={self._openscad_cli_quote(v)}" for k, v in parameters.items()]
        )
        command = f"openscad --backend Manifold --enable textmetrics -o {output_file} --export-format {format} {cli_params} {input_file}"
        logger.debug(f"Running command: {command}")
        result = subprocess.run(
            command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        logger.debug(f"Command output: {result.stdout.decode().replace('\n\n', '\n')}")
        logger.debug(f"Command errors: {result.stderr.decode().replace('\n\n', '\n')}")
        if result.returncode != 0:
            logger.error(
                f"Error executing command: {command} | stderr: {result.stderr.decode()} | stdout: {result.stdout.decode()}"
            )
            return False
        return True
