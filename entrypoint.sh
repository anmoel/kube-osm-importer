#!/bin/bash

for file in `ls /data/*.osm.pbf`; do
  osm2pgsql -d $PG_DATABASE --create --slim  -G --hstore --tag-transform-script ~/src/openstreetmap-carto/openstreetmap-carto.lua \
    -C 2500 --number-processes 1 -S ~/src/openstreetmap-carto/openstreetmap-carto.style /data/$file \
    -H $PG_HOST -P $PG_PORT -U $PG_USER  -W $PG_PASSWORD

done