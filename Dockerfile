# Use the official PostgreSQL image as the base
FROM postgres:latest

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=sakila

# Copy your database dump into the Docker image for automatic initialization
COPY sakila_backup.dump /docker-entrypoint-initdb.d/

# Install Python and necessary packages
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install psycopg2-binary ipython-sql

# Copy the entire repository into the working directory
COPY . /home/jovyan/

# Set the working directory
WORKDIR /home/jovyan

# Optionally, expose the PostgreSQL port if you want to access it
EXPOSE 5432
