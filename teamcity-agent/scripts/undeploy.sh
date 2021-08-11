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

echo "Delete Teamcity Agent $agent_no..."

helm uninstall \
  "$release-$agent_no" \
  --namespace "$namespace"

sleep 5s

echo "Teamcity Agent $agent_no deleted successfully..."
