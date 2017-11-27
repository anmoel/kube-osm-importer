#!/bin/bash

for file in `ls /data/*.osm.pbf`; do
  osm2pgsql -d $PGDATABASE --create --slim  -G --hstore --tag-transform-script /src/openstreetmap-carto/openstreetmap-carto.lua \
    -C 2500 --number-processes 1 -S /src/openstreetmap-carto/openstreetmap-carto.style /data/$file \
    -H $PGHOST -P $PGPORT -U $PGUSER  -W $PGPASSWORD

done

/src/openstreetmap-carto/scripts/indexes.py | psql -d $PGDATABASE -h $PGHOST -P $PGPORT -U $PGUSER  -W $PGPASSWORD