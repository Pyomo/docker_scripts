RUN echo "" && \
    echo "==============" && \
    echo "INSTALLING CBC" && \
    echo "==============" && \
    echo ""
ENV CBC_VERSION="2.10.1"
ARG TARGET="Cbc-${CBC_VERSION}"
ENV PATH="${PREFIX}/${TARGET}/build/bin:${PATH}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.tgz && \
    wget -q "https://www.coin-or.org/download/source/Cbc/${TARGET}.tgz" && \
    tar xf ${TARGET}.tgz && \
    rm -rf ${TARGET}.tgz && \
    cd ${PREFIX}/${TARGET}/ThirdParty && \
    cd ASL && ./get.ASL 2> /dev/null && cd .. && \
    cd Blas && ./get.Blas 2> /dev/null && cd .. && \
    cd Glpk && ./get.Glpk 2> /dev/null && cd .. && \
    cd Lapack && ./get.Lapack 2> /dev/null && cd .. && \
    cd Metis && ./get.Metis 2> /dev/null && cd .. && \
    cd Mumps && ./get.Mumps 2> /dev/null && cd .. && \
    cd .. && \
    mkdir build && \
    cd build && \
    ../configure CXX=g++ CC=gcc F77=gfortran --disable-mysql > /dev/null && \
    make -j$(nproc) > /dev/null && \
    make install > /dev/null
ARG TARGET
