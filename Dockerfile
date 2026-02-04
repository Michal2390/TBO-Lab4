# Dockerfile for TBO-Lab4 iOS Security Testing
# This is a minimal Swift container for demonstration purposes

FROM swift:5.9-focal

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies (if any)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Expose port for demo purposes
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Default command (for demonstration)
CMD ["echo", "TBO-Lab4 iOS Security Testing Container"]