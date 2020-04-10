RUN echo "" && \
    echo "================" && \
    echo "INSTALLING IPOPT" && \
    echo "================" && \
    echo ""
ARG TARGET="idaes-solvers-ubuntu1804-64"
ENV IDAES_VERSION="2.0.0"
ARG IPOPT_DIR="IDAES-IPOPT-${IDAES_VERSION}"
ENV PATH="${PREFIX}/IDAES_${IDAES_VERSION}/${IPOPT_DIR}:${PATH}"
RUN mkdir -p ${PREFIX}/IDAES_${IDAES_VERSION}/${IPOPT_DIR} && \
    cd ${PREFIX}/IDAES_${IDAES_VERSION}/${IPOPT_DIR} && \
    wget -q "https://github.com/IDAES/idaes-ext/releases/download/2.0.0/idaes-solvers-ubuntu1804-64.tar.gz" && \
    tar -xzf ${TARGET}.tar.gz && \
    rm -rf ${TARGET}.tar.gz
RUN ${PREFIX}/IDAES_${IDAES_VERSION}/ipopt
ARG TARGET
