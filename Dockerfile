# Use a base Jupyter image that has PostgreSQL installed
FROM jupyter/minimal-notebook

# Install necessary Python packages
RUN pip install psycopg2-binary ipython-sql pandas

# Copy your database dump into the image
COPY W2D4/data/sakila_backup.dump /home/jovyan/

# Create a script to set up PostgreSQL and the database
RUN apt-get update && apt-get install -y postgresql postgresql-contrib && \
    service postgresql start && \
    sudo -u postgres createdb sakila && \
    sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';" && \
    sudo -u postgres pg_restore -U postgres -d sakila /home/jovyan/sakila_backup.dump

# Modify PostgreSQL config to allow connections (this is optional)
RUN echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/*/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/*/main/postgresql.conf
