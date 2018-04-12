##DRAFT under development
##############################################################################
# TODO:
# * Just one/two layers
# ** Layer One for apk, installations/git clone/build, cleanup
# * Decide a common place for each script 
# * Add: snakes.pl
# * CI with VSOnline? TravisCI?
# * Add CC0 file.
# * Write documentation.
##############################################################################



FROM alpine:3.7

ARG foo

LABEL test="$foo"

##############################################################################
# pipes.sh
##############################################################################
RUN apk update && \
	apk upgrade && \
  apk add --no-cache git wget unzip && \
  apk add --no-cache make bash ncurses

RUN BASE_SRC="src"; \
    mkdir $BASE_SRC; 

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/pipes.sh"; \
    FILE_NAME="pipes.sh"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    make PREFIX=$HOME/.local install; \
    cd ..

###Placed in the home directory
###/root/.local/bin

##############################################################################
# pipes.c
##############################################################################

RUN apk add --no-cache gcc musl-dev autoconf automake ncurses-dev

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/pipes.c"; \
    FILE_NAME="pipes.c"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    git clone git://git.sv.gnu.org/autoconf-archive.git; \
    autoreconf -i -I autoconf-archive/m4; \
    ./configure && make && make install

# cpipes


##############################################################################
# maze.py
##############################################################################

RUN apk add --no-cache python py-pip python3-dev

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/maze.py"; \
    FILE_NAME="maze.py"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    pwd; \
    pip3 install .

##############################################################################
# pipesX.sh
##############################################################################

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/pipesX.sh"; \
    FILE_NAME="pipesX.sh"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    make PREFIX=$HOME/.local install; 
# pipesX.sh /root/.local/bin

##############################################################################
# weave.sh
##############################################################################

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/weave.sh"; \
    FILE_NAME="weave.sh"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    cp weave.sh /root/.local/bin; \
    chmod 0755 /root/.local/bin/weave.sh
# weave.sh root/.local/bin/weave.sh


##############################################################################
# snakes.pl
##############################################################################

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/snakes.pl"; \
    FILE_NAME="snakes.pl"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    cp weave.sh /root/.local/bin; \
    chmod 0755 /root/.local/bin/weave.sh
# weave.sh root/.local/bin/weave.sh

##############################################################################
# Clean up
##############################################################################
#RUN rm -rf /var/cache/apk/*; \
#    apk del git wget unzip make gcc musl-dev autoconf automake
    

