## Docker
```
export RUNNER_TOKEN=<your-token>
docker build --build-arg RUNNER_TOKEN=$RUNNER_TOKEN -t github-runner .
docker run github-runner
```
## Docker Compose
```
export RUNNER_TOKEN=<your-token>
docker-compose up
```
