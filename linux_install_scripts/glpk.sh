RUN echo "" && \
    echo "===============" && \
    echo "INSTALLING GLPK" && \
    echo "===============" && \
    echo ""
ENV GLPK_VERSION="4.65"
ARG TARGET="glpk-${GLPK_VERSION}"
ENV PATH="${PREFIX}/${TARGET}/build/bin:${PATH}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.tar.gz && \
    wget -q "https://ftp.gnu.org/gnu/glpk/${TARGET}.tar.gz" && \
    tar xf ${TARGET}.tar.gz && \
    rm -rf ${TARGET}.tar.gz && \
    mkdir ${TARGET}/build && \
    cd ${TARGET}/build && \
    ../configure CXX=g++ CC=gcc F77=gfortran --prefix=${PREFIX}/${TARGET}/build > /dev/null && \
    make -j$(nproc) > /dev/null && \
    make install > /dev/null
ARG TARGET
