#!/bin/bash

# Enable strict error handling and debug mode
set -ex

# Function to check if the server is up
function ping_server() {
  counter=0
  max_attempts=200      # Maximum number of attempts
  sleep_interval=0.5    # Time to wait between attempts in seconds

  while [[ ${counter} -lt ${max_attempts} ]]; do
    response=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8080")
    if [[ ${response} -eq 200 ]]; then
      echo "Server is up and running!"
      return 0
    fi
    let counter++
    if (( counter % 20 == 0 )); then
      echo "Waiting for server to start... (${counter}/${max_attempts})"
    fi
    sleep ${sleep_interval}
  done

  echo "Failed to start the server within the expected time."
  exit 1
}

# Start live-server in the background and log output
live-server --host=0.0.0.0 --port=8080 --no-browser > /app/live-server.log 2>&1 &

# Wait for the server to be up
ping_server

# Keep the script running to maintain the container's lifecycle
wait
