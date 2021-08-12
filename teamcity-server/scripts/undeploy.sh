#!/bin/bash
set -o errexit  # Force to exist on error
set -o errtrace # Print error trace
set -o nounset  # Exit when variables are not initialized
#set -o xtrace # Print debug for all executed commands

gitroot=$(git rev-parse --show-toplevel)

namespace="${1:-teamcity}"
release="${2-teamcity-server}"

echo "------------------------------"
echo "KUBECONFIG: $KUBECONFIG"
echo "Namespace: $namespace"
echo "Release: $release"
echo "------------------------------"

echo "Delete Teamcity Server..."

helm uninstall \
  "$release" \
  --namespace "$namespace"

sleep 5s

echo "Teamcity Server deleted successfully..."
