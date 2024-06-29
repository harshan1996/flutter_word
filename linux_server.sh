#! /bin/bash

# Define the port
PORT=5005

# Check if the port is in use and release it if necessary.
echo "Checking if port $PORT is in use..."
if [ "$(lsof -t -i :$PORT)" ]; then
  echo "Port $PORT is in use. Stopping the process..."
  fuser -k -n tcp $PORT
fi

# Start the linux device on the specified port
echo "Starting the server on port $PORT..."

./build/linux/x64/debug/bundle/client