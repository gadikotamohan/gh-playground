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
