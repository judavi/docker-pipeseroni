##DRAFT under development


FROM alpine:3.7

##############################################################################
# pipes.s
##############################################################################
RUN apk update && \
	apk upgrade && \
  apk add --no-cache git wget unzip && \
  apk add --no-cache make bash ncurses

RUN BASE_SRC="src"; \
    mkdir $BASE_SRC; 

RUN cd $BASE_SRC; \
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
    GIT_URL="https://github.com/pipeseroni/pipes.c"; \
    FILE_NAME="pipes.c"; \
    git clone $GIT_URL; \
    cd $FILE_NAME; \
    git clone git://git.sv.gnu.org/autoconf-archive.git; \
    autoreconf -i -I autoconf-archive/m4; \
    ./configure && make && make install

# cpipes

##############################################################################
# Clean up
##############################################################################
RUN rm -rf /var/cache/apk/*; \
    apk del git wget unzip make gcc musl-dev autoconf automake
    

