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

echo "Deploying Teamcity Server..."

helm install \
  -f "${gitroot}/teamcity-server/tc-server-chart/values.yaml" \
  --namespace "$namespace" \
  "$release" \
  "${gitroot}/teamcity-server/tc-server-chart/"

echo "Teamcity Server deployed successfully..."
