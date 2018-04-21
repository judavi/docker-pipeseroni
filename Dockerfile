##############################################################################
# TODO:
# * Just one/two layers
# * CI with VSOnline? TravisCI?
# * Write documentation.
##############################################################################
FROM alpine:3.7

ENV BASE_SRC=src

##############################################################################
# pipes.sh (execute using pipes.sh)
##############################################################################
RUN apk update && \
	apk upgrade && \
  apk add --no-cache git wget unzip && \
  apk add --no-cache make bash ncurses && \
  mkdir $BASE_SRC && \
  cd $BASE_SRC  && \
  GIT_URL='https://github.com/pipeseroni/pipes.sh'  && \
  FILE_NAME='pipes.sh'  && \
  git clone $GIT_URL  && \
  cd $FILE_NAME  && \
  make install  && \
  cd ..

##############################################################################
# pipes.c  (execute using cpipes)
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
    cp $FILE_NAME /bin; \
    chmod 0755 /bin/$FILE_NAME

##############################################################################
# pipesX.sh (execute using pipesx.sh)
##############################################################################

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/pipesX.sh"; \
    FILE_NAME="pipesX.sh"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    make install

##############################################################################
# weave.sh (execute weave.sh)
##############################################################################

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/weave.sh"; \
    FILE_NAME="weave.sh"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    cp weave.sh /bin; \
    chmod 0755 /bin/weave.sh

##############################################################################
# snakes.pl (execute snakes.pl)
##############################################################################

RUN BASE_SRC="src"; \
    cd $BASE_SRC; \
    GIT_URL="https://github.com/pipeseroni/snakes.pl"; \
    FILE_NAME="snakes.pl"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    cp snake.pl /bin; \
    chmod 0755 /bin/snake.pl

##############################################################################
# Clean up
##############################################################################
RUN rm -rf $BASE_SRC; \
    rm -rf /var/cache/apk/*; \
    apk del git wget unzip make gcc musl-dev autoconf automake
    

