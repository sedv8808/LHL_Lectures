# Use the official Jupyter base image
FROM jupyter/base-notebook:latest

# Install PostgreSQL and other dependencies
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=sakila

# Copy the database dump into the Docker image for automatic initialization
COPY W2D4/data/sakila_backup.dump /docker-entrypoint-initdb.d/

# Install Python packages (including pandas)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose PostgreSQL port
EXPOSE 5432
