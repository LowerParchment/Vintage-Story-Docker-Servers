# Grab the base image
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation that must be manually confirmed
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies + Microsoft package repo for .NET runtime (required)
RUN apt-get update && apt-get install -y \
    wget \
    apt-transport-https \
    software-properties-common \
    ca-certificates \
    libssl1.1 \
    libcurl4 \
    screen \
    unzip \
    gnupg \
    && wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y dotnet-runtime-7.0 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /vsserver

# Copy server files
COPY server/ /vsserver

# Make executables runnable
RUN chmod +x /vsserver/server.sh /vsserver/VintagestoryServer

# Expose default port (Vintagestory server port is 42420)
EXPOSE 42420

# Mount data and mods as volumes
VOLUME ["/vsserver/data", "/vsserver/Mods"]

# Copy start wrapper into container
COPY start.sh /vsserver/start.sh

# Make sure the script is executable
RUN chmod +x /vsserver/start.sh

# Final command to start the server
CMD ["./start.sh"]