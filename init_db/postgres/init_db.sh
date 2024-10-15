#!/bin/bash
set -eux

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Demo PostgreSQL Database initialisation
psql postgres -c "CREATE USER testuser PASSWORD 'testpass'"
#The -O flag below sets the user: createdb -O DBUSER DBNAME
createdb -O testuser testdb
createdb -O testuser sakila
createdb -O testuser insurance

# Restore the sakila database from the dump file
psql -U testuser -d sakila -f /home/jovyan/W2D4/data/sakila_backup.sql

# Restore the Insurance database from the SQL file
psql -U testuser -d insurance -f /home/jovyan/W1D4/data/insurance.sql

psql -d testdb -U testuser -f $THISDIR/seed_db.sql