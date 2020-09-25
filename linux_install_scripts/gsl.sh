RUN echo "" && \
    echo "==============" && \
    echo "INSTALLING GSL" && \
    echo "==============" && \
    echo ""
ARG TARGET="amplgsl.linux-intel64"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.zip && \
    wget -q "https://www.ampl.com/NEW/amplgsl/${TARGET}.zip" && \
    mkdir Gsl && \
    unzip -q -d Gsl ${TARGET}.zip && \
    cd Gsl && \
    echo '#include <stdio.h>\n\
extern const char* gsl_version;\n\
int main(void)\n\
{\n\
  printf("GSL_VERSION %s\\n", gsl_version);\n\
  return 0;\n\
}' > tmp.c && \
    gcc ./amplgsl.dll ./tmp.c -Wl,-R -Wl,. -o tmp && ./tmp >> ${DYNAMIC_VARS_FILE} && \
    rm ./tmp && \
    rm ./tmp.c && \
    ln -s ${PREFIX}/Gsl/amplgsl.dll /usr/local/lib/amplgsl.dll
ARG TARGET
