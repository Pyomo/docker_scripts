RUN echo "" && \
    echo "================" && \
    echo "INSTALLING MIPCL" && \
    echo "================" && \
    echo ""
ENV MIPCL_VERSION="2.1.1"
ARG TARGET="mipcl-${MIPCL_VERSION}"
ENV PATH="${PREFIX}/${TARGET}/bin:${PATH}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.linux-x86_64.tar.gz && \
    wget -q "http://www.mipcl-cpp.appspot.com/static/download/${TARGET}.linux-x86_64.tar.gz" && \
    tar xf ${TARGET}.linux-x86_64.tar.gz && \
    rm -rf ${TARGET}.linux-x86_64.tar.gz
ARG TARGET
