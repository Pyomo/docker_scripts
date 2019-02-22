#
# Install gjh_asl_json
#
RUN echo "" && \
    echo "=======================" && \
    echo "INSTALLING GJH_ASL_JSON" && \
    echo "=======================" && \
    echo ""
ARG TARGET="gjh_asl_json-master"
ENV PATH="${PREFIX}/${TARGET}/bin:${PATH}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.zip && \
    wget -q "https://codeload.github.com/ghackebeil/gjh_asl_json/zip/master" -O ${TARGET}.zip && \
    unzip -q ${TARGET}.zip && \
    rm -rf ${TARGET}.zip && \
    cd ${TARGET}/Thirdparty && ./get.ASL 2> /dev/null && \
    cd .. && \
    make -j$(nproc) > /dev/null && \
    echo GJH_ASL_JSON_VERSION `${PREFIX}/${TARGET}/bin/gjh_asl_json -v` >> ${DYNAMIC_VARS_FILE}
ARG TARGET
