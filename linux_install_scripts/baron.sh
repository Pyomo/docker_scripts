RUN echo "" && \
    echo "================" && \
    echo "INSTALLING BARON" && \
    echo "================" && \
    echo ""
ARG TARGET="baron-lin64"
ENV PATH="${PREFIX}/${TARGET}:${PATH}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.zip && \
    wget -q "https://www.minlp.com/downloads/xecs/baron/current/${TARGET}.zip" && \
    unzip -q ${TARGET}.zip && \
    rm -rf ${TARGET}.zip && \
    echo 'OPTIONS {\n\
results: 1;\n\
ResName: "dummy.res";\n\
summary: 1;\n\
SumName: "dummy.sum";\n\
times: 1;\n\
TimName: "dummy.tim";\n\
}\n\
POSITIVE_VARIABLES x1;\n\
OBJ: minimize x1;' > dummy.bar && \
    echo BARON_VERSION `${PREFIX}/${TARGET}/baron -f dummy.bar | grep -Po 'BARON version .*\. Built' | grep -Po '\d+.\d+.\d+'` >> ${DYNAMIC_VARS_FILE} && \
    rm -f dummy.bar dummy.res dummy.sum dummy.tim dummy.prob
ARG TARGET
