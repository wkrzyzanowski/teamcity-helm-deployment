#!/bin/bash
set -o errexit  # Force to exist on error
set -o errtrace # Print error trace
set -o nounset  # Exit when variables are not initialized
#set -o xtrace # Print debug for all executed commands

gitroot=$(git rev-parse --show-toplevel)

agent_no="${1}"
namespace="${2:-teamcity}"
release="${3-teamcity-agent}"

echo "------------------------------"
echo "KUBECONFIG: $KUBECONFIG"
echo "Agent number: $agent_no"
echo "Namespace: $namespace"
echo "Release: $release"
echo "------------------------------"

echo "Building Docker image for Teamcity Agent $agent_no"
source "${gitroot}/teamcity-agent/docker/buildImage.sh" "$agent_no"

echo "Deploying Teamcity Agent $agent_no..."

helm install \
  -f "${gitroot}/teamcity-agent/tc-agent-chart/values.yaml" \
  --set "labels.componentName=teamcity_agent_$agent_no" \
  --set "tcagent.BUILD_AGENT_NO=$agent_no" \
  --set "image.repository=localhost:32000/teamcity_agent_$agent_no" \
  --namespace "$namespace" \
  "$release-$agent_no" \
  "${gitroot}/teamcity-agent/tc-agent-chart/"

echo "Teamcity Agent $agent_no deployed successfully..."
