#! /bin/bash

# Define the port
PORT=5005

# Check if the port is in use and release it if necessary.
echo "Checking if port $PORT is in use..."
if [ "$(lsof -t -i :$PORT)" ]; then
  echo "Port $PORT is in use. Stopping the process..."
  fuser -k -n tcp $PORT
fi

# Switch to the web construction directory
cd ./build/web/

# Start the web server on the specified port
echo "Starting the server on port $PORT..."

# This is for the web app
python3 -m http.server $PORT