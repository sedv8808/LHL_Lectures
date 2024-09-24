#!/bin/bash
set -eux

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Demo PostgreSQL Database initialisation
psql postgres -c "CREATE USER testuser PASSWORD 'testpass'"
#The -O flag below sets the user: createdb -O DBUSER DBNAME
createdb -O testuser testdb
createdb -O testuser sakila

# Restore the sakila database from the dump file
psql -U testuser -d sakila -f /home/jovyan/W2D4/data/sakila_backup.sql

psql -d testdb -U testuser -f $THISDIR/seed_db.sql