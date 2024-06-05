#!/bin/bash
  
# Variables
projectFolder="."
envName="snakemake_env"
snakemakeVersion="8.4.6"
envFile="$projectFolder/environment.yaml"
summary=false

# Parse arguments
for arg in "$@"
do
    if [ "$arg" == "--summary" ]; then
        summary=true
        break
    fi
done

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

# Produce supporting plots instead of running Snakemake if the summary option is selected
if [ "$summary" == true ]; then
    mkdir -p summary
    snakemake --dag --forceall | dot -Tpng > summary/dag.png
    snakemake --rulegraph --forceall | dot -Tpng > summary/rulegraph.png
    snakemake --filegraph --forceall | dot -Tpng > summary/filegraph.png
else
    # Run Snakemake
    snakemake -s "$projectFolder/workflow/Snakefile" \
              --configfile "$projectFolder/config/config.yaml" \
              --cores "$cores" \
              --use-conda \
              -p \
              --latency-wait 60 \
              "$@"
fi

# Deactivate the conda environment
conda deactivate
