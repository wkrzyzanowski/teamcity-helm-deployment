#!/bin/bash
set -o errexit  # Force to exist on error
set -o errtrace # Print error trace
set -o nounset  # Exit when variables are not initialized
#set -o xtrace # Print debug for all executed commands

gitroot=$(git rev-parse --show-toplevel)

namespace="${1:-teamcity}"
release="${2-teamcity-database}"

echo "------------------------------"
echo "KUBECONFIG: $KUBECONFIG"
echo "Namespace: $namespace"
echo "Release: $release"
echo "------------------------------"

echo "Setting up TEAMCITY_DATABASE credentials..."
source "${gitroot}/scripts/exportEnvs.sh"

echo "Deploying Teamcity Database..."

helm install \
  -f "${gitroot}/teamcity-db/postgres-db-chart/values.yaml" \
  --set "postgresdb.environment.POSTGRES_USER=${TC_DATABASE_USER}" \
  --set "postgresdb.environment.POSTGRES_PASSWORD=${TC_DATABASE_PASSWORD}" \
  --namespace "$namespace" \
  "$release" \
  "${gitroot}/teamcity-db/postgres-db-chart/"

echo "IMPORTANT! Teamcity Database address: $release-postgres-db:5432"

echo "Teamcity Database deployed successfully..."
