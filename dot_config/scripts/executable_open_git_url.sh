#!/bin/bash

# Function to extract the repository URL
extract_repository_url() {
    git remote -v | grep origin | grep -oE '(git@[^ ]+)' | head -n1
}

# Function to convert SSH URL to HTTPS URL for GitLab
convert_gitlab_ssh_to_https() {
    local ssh_url="$1"
    local host_with_user_and_repo=$(echo "$ssh_url" | sed 's/git@\([^:]\+:\)\(.*\)\.git/\1\2/')
    local host_with_repo=$(echo "$host_with_user_and_repo" | sed 's/:/\//')
    echo "https://$host_with_repo"
}

# Function to convert SSH URL to HTTPS URL for GitHub
convert_github_ssh_to_https() {
    local ssh_url="$1"
    local user_and_repo=$(echo "$ssh_url" | sed 's/git@github.com:\(.*\)\.git/\1/')
    echo "https://github.com/$user_and_repo"
}

# Function to convert SSH URL to HTTPS URL for Bitbucket
convert_bitbucket_ssh_to_https() {
    local ssh_url="$1"
    local user_and_repo=$(echo "$ssh_url" | sed 's/git@bitbucket.org:\(.*\)\.git/\1/')
    echo "https://bitbucket.org/$user_and_repo"
}

# Function to open the repository URL
open_repository_url() {
    local REMOTE_URL=$(extract_repository_url)

    # If the repository URL is found, open it in the default web browser
    if [ -n "$REMOTE_URL" ]; then
        # Check if it's a GitLab, GitHub, or Bitbucket URL
        if [[ "$REMOTE_URL" == *"gitlab.com"* ]]; then
            local REPO_URL=$(convert_gitlab_ssh_to_https "$REMOTE_URL")
            echo "Opening GitLab URL: $REPO_URL"
        elif [[ "$REMOTE_URL" == *"github.com"* ]]; then
            local REPO_URL=$(convert_github_ssh_to_https "$REMOTE_URL")
            echo "Opening GitHub URL: $REPO_URL"
        elif [[ "$REMOTE_URL" == *"bitbucket.org"* ]]; then
            local REPO_URL=$(convert_bitbucket_ssh_to_https "$REMOTE_URL")
            echo "Opening Bitbucket URL: $REPO_URL"
        else
            echo "Unsupported repository URL format."
            return 1
        fi
        open "$REPO_URL"
    else
        echo "Repository URL not found in the current directory."
        return 1
    fi
}

