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
