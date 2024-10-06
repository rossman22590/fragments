# Use a lightweight Node.js image
FROM node:18-slim

# Install curl
RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install live-server globally
RUN npm install -g live-server

# Set the working directory
WORKDIR /app

# Copy the index.html into the container
COPY index.html /app/index.html

# Copy the compile_page.sh script into the container
COPY compile_page.sh /compile_page.sh
RUN chmod +x /compile_page.sh

# Expose port 8080 for live-server
EXPOSE 8080

# Start the server
CMD ["/compile_page.sh"]
