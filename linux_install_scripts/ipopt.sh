RUN echo "" && \
    echo "================" && \
    echo "INSTALLING IPOPT" && \
    echo "================" && \
    echo ""
ARG TARGET="idaes-solvers-ubuntu1804-64"
ENV IPOPT_VERSION="2.0.0"
ARG IPOPT_DIR="IDAES-IPOPT-${IPOPT_VERSION}"
ENV PATH="${PREFIX}/IDAES_${IPOPT_VERSION}/${IPOPT_DIR}:${PATH}"
RUN mkdir -p ${PREFIX}/IDAES_${IPOPT_VERSION}/${IPOPT_DIR} && \
    cd ${PREFIX}/IDAES_${IPOPT_VERSION}/${IPOPT_DIR} && \
    wget -q "https://github.com/IDAES/idaes-ext/releases/download/2.0.0/idaes-solvers-ubuntu1804-64.tar.gz" && \
    tar -xzf ${TARGET}.tar.gz && \
    rm -rf ${TARGET}.tar.gz
ARG TARGET
