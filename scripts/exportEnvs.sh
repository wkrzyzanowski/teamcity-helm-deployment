#!/bin/bash
set -o errexit  # Force to exist on error
set -o errtrace # Print error trace
set -o nounset  # Exit when variables are not initialized
#set -o xtrace # Print debug for all executed commands

echo "Export secrets for Teamcity Database..."

# THIS SCRIPT SHOULD BE SOURCED BEFORE DEPLOYMENT
export readonly TC_DATABASE_USER=${TC_DATABASE_USER}
export readonly TC_DATABASE_PASSWORD=${TC_DATABASE_PASSWORD}

echo "Export secrets successful!"
