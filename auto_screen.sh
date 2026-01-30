#!/bin/bash
#
# Auto-attach to GNU Screen session on login
# This script automatically starts or reattaches to a screen session

# Name for the screen session
SESSION_NAME="main"

# Check if we're already inside a screen session
if [ -n "$STY" ]; then
    # Already in screen, do nothing
    exit 0
fi

# Check if screen is installed
if ! command -v screen &> /dev/null; then
    echo "GNU Screen is not installed. Please install it first."
    echo "On Ubuntu/Debian: sudo apt-get install screen"
    echo "On CentOS/RHEL: sudo yum install screen"
    exit 1
fi

# Check if a screen session with our name exists
if screen -list | grep -q "$SESSION_NAME"; then
    # Session exists, reattach to it
    echo "Reattaching to existing screen session '$SESSION_NAME'..."
    exec screen -r "$SESSION_NAME"
else
    # No session exists, create a new one
    echo "Creating new screen session '$SESSION_NAME'..."
    exec screen -S "$SESSION_NAME"
fi
