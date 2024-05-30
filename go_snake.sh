#!/bin/bash
  
# Variables
projectFolder="."
envName="snakemake_env"
snakemakeVersion="8.4.6"
envFile="$projectFolder/environment.yaml"

# Create and activate the Conda environment if it doesn't exist
if ! conda env list | grep -q $envName; then
    if [ -f "$envFile" ]; then
        echo "Creating Conda environment '$envName' from $envFile"
        mamba env create -n $envName -f "$envFile"
    else
        echo "Creating Conda environment '$envName' with Snakemake-minimal $snakemakeVersion"
        mamba create -y -n $envName -c bioconda -c conda-forge snakemake-minimal=$snakemakeVersion
    fi
fi

# Activate the Conda environment
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate $envName

# Run Snakemake
snakemake -s "$projectFolder/workflow/Snakefile" \
          --configfile "$projectFolder/config/config.yaml" \
          --cores 1 \
          --latency-wait 60 \
          "$@"

# Deactivate the Conda environment
conda deactivate

