#!/bin/bash

# Create a named pipe
PIPE=/tmp/vsserver.pipe
rm -f "$PIPE"
mkfifo "$PIPE"

# Inject startup commands into the pipe in the background
(
  echo "/serverconfig whitelistmode off"
) > "$PIPE" &

# Start server reading from both the pipe and live input
cat "$PIPE" - | ./VintagestoryServer