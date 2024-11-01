#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Homebrew is installed
if command_exists brew; then
    echo "Homebrew is installed."
else
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Verify Homebrew installation
    if command_exists brew; then
        echo "Homebrew installation complete."
    else
        echo "Homebrew installation failed. Please install it manually."
        exit 1
    fi
fi

echo "Installing gtk4..."
brew install gtk4
echo "gtk4 installation complete."

echo "Installing create-dmg for creating DMG files..."
brew install create-dmg
echo "create-dmg installation complete."