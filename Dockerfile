# Use the latest Ubuntu LTS as the base image
FROM ubuntu:20.04

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        git \
        jq \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for the runner
WORKDIR /actions-runner

#  # Create a folder
# $ mkdir actions-runner && cd actions-runner
# # Download the latest runner package
# $ curl -o actions-runner-linux-x64-2.314.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.314.1/actions-runner-linux-x64-2.314.1.tar.gz
# # Optional: Validate the hash
# $ echo "6c726a118bbe02cd32e222f890e1e476567bf299353a96886ba75b423c1137b5  actions-runner-linux-x64-2.314.1.tar.gz" | shasum -a 256 -c
# # Extract the installer
# $ tar xzf ./actions-runner-linux-x64-2.314.1.tar.gz
# Configure
# # Create the runner and start the configuration experience
# $ ./config.sh --url https://github.com/gadikotamohan/gh-playground --token AAVFPZKKW7XTAXLQG4SGKTDF5F2K6


# Download and install the GitHub Actions runner
RUN curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v2.283.1/actions-runner-linux-x64-2.283.1.tar.gz \
    && tar xzf ./actions-runner-linux-x64.tar.gz \
    && ./bin/installdependencies.sh \
    && rm -f actions-runner-linux-x64.tar.gz

# Set the RUNNER_TOKEN environment variable
ARG RUNNER_TOKEN
ENV RUNNER_TOKEN=$RUNNER_TOKEN
ENV RUNNER_ALLOW_RUNASROOT=true
# Copy entrypoint script
COPY entrypoint.sh .

# Set the entrypoint script as executable
RUN chmod +x entrypoint.sh

# Start the runner
CMD ["./entrypoint.sh"]
