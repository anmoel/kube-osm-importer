FROM ubuntu:xenial
MAINTAINER André Möller <moeller@mecom.de>

RUN apt-get update && \
    apt-get install -y git make cmake g++ libboost-dev libboost-system-dev \
        libboost-filesystem-dev libexpat1-dev zlib1g-dev libbz2-dev libpq-dev \
        libgeos-dev libgeos++-dev libproj-dev lua5.2 liblua5.2-dev && \
    mkdir ~/src && \
    cd ~/src && \
    git clone git://github.com/openstreetmap/osm2pgsql.git && \
    cd osm2pgsql && \
    apt-get install -y make cmake g++ libboost-dev libboost-system-dev \
    libboost-filesystem-dev libexpat1-dev zlib1g-dev libbz2-dev libpq-dev \
    libgeos-dev libgeos++-dev libproj-dev lua5.2 liblua5.2-dev && \
    mkdir build && cd build && \
    cmake .. && make && make install && \
    npm install -g carto && \
    cd ~/src && \
    git clone git://github.com/gravitystorm/openstreetmap-carto.git && \
    cd openstreetmap-carto && carto project.mml > mapnik.xml && scripts/get-shapefiles.py


VOLUME /data
ADD entrypoint.sh /

CMD /entrypoint.sh