# run_snakemake
Bash script and basic structure to install and run a snakemake workflow

In `go_snake.sh` you can define the project folders, a conda environment name and snakemake version (or use an environment.yaml file). The script will:

- Check if the conda environment already exists.
- If needed, create it from the `environment.yaml` file
- If it doesn't exist, create an environment with just a snakemake-minimal
- Activate the conda environment
- Execute the snakemake workflow
- deactivate the environment

This is just a template with a minimal working example

# usage

To execute the workflow:
```bash
bash go_snake.sh
```
You can add additional options that will be parsed to the snakemake command.

To produce dag, filegraph and rulegraph plots
```bash
bash go_snake.sh --summary
```

If the the `envFile`  exists (default is `$projectFolder/environment.yaml`), the environment defined in `envName` (default `snakemake_env`) will be created if it doesn't exist under your conda installation. You can select the `snakemakeVersion` to be installed if the environment.yaml file does not exist.
