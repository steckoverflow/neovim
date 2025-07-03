#!/bin/bash

# Script to delete Neovim's local data directory
# This removes cached files, plugins, and other local data

NVIM_DIR="$HOME/.local/share/nvim"

# Check if the directory exists
if [ -d "$NVIM_DIR" ]; then
    echo "Found Neovim directory at: $NVIM_DIR"
    echo "Deleting directory..."
    
    # Remove the directory and all its contents
    rm -rf "$NVIM_DIR"
    
    # Verify deletion
    if [ ! -d "$NVIM_DIR" ]; then
        echo "✅ Successfully deleted $NVIM_DIR"
    else
        echo "❌ Failed to delete $NVIM_DIR"
        exit 1
    fi
else
    echo "Neovim directory not found at: $NVIM_DIR"
    echo "Nothing to delete."
fi

echo "Script completed."
