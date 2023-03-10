#!/bin/bash

# exit when any command fails
set -ex  

# Allow this script to be run from other locations,
# despite the relative file paths
if [[ $BASH_SOURCE = */* ]]; then
    cd -- "${BASH_SOURCE%/*}/" || exit
fi

# Common setup
./0-setup.sh


echo "running the pipeline"
PIPELINE_RUN_K8S_NAME=$(oc create -n pipeline-ace -f ./simple-pipelinerun.yaml -o name)
echo $PIPELINE_RUN_K8S_NAME
PIPELINE_RUN_NAME=${PIPELINE_RUN_K8S_NAME:23}

echo "tailing pipeline logs"
tkn pipelinerun logs -n pipeline-ace --follow $PIPELINE_RUN_NAME

echo "pipeline complete"
