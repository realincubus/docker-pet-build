############################################################
# Copyright (c) 2016 Stefan Kemnitz
# Released under the MIT license
############################################################

# ├─yantis/archlinux-tiny
#   ├─realincubus/docker-clang-build

FROM realincubus/docker-clang-build
MAINTAINER Stefan Kemnitz <kemnitz.stefan@googlemail.com>

RUN pacman --noconfirm -Rdd texinfo-fake && \
    pacman --noconfirm -S git bison flex autogen autoconf automake libtool texinfo libyaml 

RUN cd ~ && \
    git clone https://github.com/realincubus/pet.git && \
    cd  pet && \
    git submodule init && \
    git submodule update && \
    sed -i.bak -e '1,3d' isl/Makefile.am && \
    ./autogen.sh && \
    ./configure  --with-clang-prefix=$HOME/install --prefix=$HOME/pet-install

RUN cd ~ && \
    cd pet && \
    make -j 8

