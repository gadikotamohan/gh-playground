#!/bin/bash

# Configure the runner with provided token
set -o xtrace

./config.sh --url https://github.com/gadikotamohan/gh-playground --token "$RUNNER_TOKEN" --name gh-playground-runner --work sample-work --labels test,sandbox,alphine-container

# Start the runner
./run.sh
