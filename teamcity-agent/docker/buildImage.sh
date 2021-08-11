#!/bin/bash
set -o errexit  # Force to exist on error
set -o errtrace # Print error trace
set -o nounset  # Exit when variables are not initialized
#set -o xtrace # Print debug for all executed commands

gitroot=$(git rev-parse --show-toplevel)

set +u
if [ -z "$1" ]; then
  echo "agent_number arg is required"
  exit 1
else
  agent_number=${1}
  echo "agent_number is set to '$agent_number'"
fi

set -u

echo "Build Docker image for teamcity_agent_$agent_number"

set -x
echo "Build 1/3..."
docker build \
  --rm \
  -t "teamcity_agent_$agent_number:latest" \
  -f "${gitroot}/teamcity-agent/docker/Dockerfile" \
  --build-arg "build_agent_number=$agent_number" \
  "${gitroot}"

echo "Tag 2/3..."
docker tag \
  "teamcity_agent_$agent_number:latest" \
  "localhost:32000/teamcity_agent_$agent_number:latest"

echo "Push 3/3..."
docker push \
  "localhost:32000/teamcity_agent_$agent_number:latest"
set +x

echo "Docker image for teamcity_agent_$agent_number built, tagged and pushed successfully!"
