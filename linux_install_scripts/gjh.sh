RUN echo "" && \
    echo "==============" && \
    echo "INSTALLING GJH" && \
    echo "==============" && \
    echo ""
ARG TARGET="gjh"
ENV PATH="${PREFIX}/Gjh/bin:${PATH}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.gz && \
    wget -q "https://ampl.com/netlib/ampl/student/linux64/${TARGET}.gz" && \
    gunzip -q ${TARGET}.gz && \
    mkdir -p Gjh/bin && \
    mv ${TARGET} Gjh/bin/ && \
    chmod u+x Gjh/bin/${TARGET} && \
    echo GJH_VERSION `Gjh/bin/${TARGET} -v` >> ${DYNAMIC_VARS_FILE}
ARG TARGET
