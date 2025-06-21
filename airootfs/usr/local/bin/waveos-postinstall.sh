#!/bin/bash
# WavesOS post-installation setup

echo "Setting up WavesOS..."

# Enable services
systemctl enable NetworkManager
systemctl enable bluetooth
# Add your other services

# Set up desktop environment
# Add your DE-specific setup here

echo "WavesOS setup complete!"
