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

docker build \
  --rm \
  -t "teamcity_agent_$agent_number:latest" \
  -f "${gitroot}/teamcity-agent/docker/Dockerfile" \
  --build-arg "build_agent_number=$agent_number" \
  "${gitroot}"

set +x

echo "Docker "
