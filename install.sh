#!bin/bash

apk update 
apk upgrade 
apk add --no-cache git wget unzip 
apk add --no-cache make bash ncurses
mkdir $BASE_SRC  

gclonecd() {
  git clone "$1" && cd "$(basename "$1")"
}

##############################################################################
# pipes.sh
##############################################################################
cd $BASE_SRC
gclonecd https://github.com/pipeseroni/pipes.sh
make PREFIX=$HOME/.local install  
cd ..

##############################################################################
# pipes.c
##############################################################################
gclonecd https://github.com/pipeseroni/pipes.c
autoreconf -i -I autoconf-archive/m4; \
./configure && make && make PREFIX=$HOME/.local install
cd ..

##############################################################################
# maze.py
##############################################################################
apk add --no-cache python py-pip python3-dev
gclonecd https://github.com/pipeseroni/maze.py
pip3 install .
cd..


##############################################################################
# pipesX.sh
##############################################################################
gclonecd https://github.com/pipeseroni/pipesX.sh
make PREFIX=$HOME/.local install
cd ..

##############################################################################
# weave.sh
##############################################################################
gclonecd https://github.com/pipeseroni/weave.sh
cp weave.sh /root/.local/bin; \
chmod 0755 /root/.local/bin/weave.sh
cd ..

##############################################################################
# snakes.pl
##############################################################################
gclonecd https://github.com/pipeseroni/snakes.pl
cp weave.sh /root/.local/bin; \
chmod 0755 /root/.local/bin/snakes.sh
cd ..

##############################################################################
# Clean up
##############################################################################
rm -rf /var/cache/apk/
apk del git wget unzip make gcc musl-dev autoconf automake py-pip python3-dev

