########################################################
# About: This shell-script lists the users of a repository in an organization of a GitHub account.
# Inputs: GitHub username and personal access token using export command to store temporarily
#   export username="  " 
#   export token="    " 
# Provide the Repo owner and Repo name as arguements while executing script.
# Author: Venu
########################################################

#!/bin/bash
set -x  # Runs script in debug mode.
set -o pipefail
# calling helper function to check script is executed with amd_args
# GitHub API URL
API_URL="https://api.github.com"

USERNAME=$username
TOKEN=$token

# User and Repository information
function helper {
    #num_args=2
    echo "num of args are $#"
    if [[ $# -ne 2 ]] # $# gives num_of arguements
    then
        echo "provide exactly 2 arguements"
        echo "Give Repo-owner and Repo-Name"
        exit 1
    fi
}
helper $@
REPO_OWNER=$1   #first arguement
REPO_NAME=$2    #second arguement


# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then   # if empty
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}


# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
