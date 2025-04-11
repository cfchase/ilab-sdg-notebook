#!/bin/bash
set -e # Exit script on first error

REPO_DIR="/opt/app-root/src/sdg-notebook"
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Repository not found. Cloning..."
    git clone --depth 1 https://github.com/rh-aiservices-bu/sdg-notebook.git "$REPO_DIR"
    echo "Installing dependencies from requirements.txt..."
    pip install --no-cache-dir -r "$REPO_DIR/requirements.txt"
elif [ "$REPO_DIR/requirements.txt" -nt "$REPO_DIR/.git" ]; then
    echo "Detected changes in requirements.txt. Reinstalling dependencies..."
    pip install --no-cache-dir -r "$REPO_DIR/requirements.txt"
else
    echo "Repository already exists. Skipping clone."
fi
exec start-notebook.sh --NotebookApp.token="" --NotebookApp.password="" "${@}"
