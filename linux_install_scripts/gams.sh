RUN echo "" && \
    echo "===============" && \
    echo "INSTALLING GAMS" && \
    echo "===============" && \
    echo ""
ARG TARGET="linux_x64_64_sfx.exe"
ARG GAMS_DIR="gams26.1_linux_x64_64_sfx"
ENV GAMS_VERSION="26.1.0"
ENV PATH="${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}:${PATH}"
RUN mkdir ${PREFIX}/GAMS_${GAMS_VERSION} && \
    cd ${PREFIX}/GAMS_${GAMS_VERSION} && \
    wget -q "https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMS_VERSION}/linux/${TARGET}" && \
    chmod u+x ${TARGET} && \
    ./${TARGET} > /dev/null && \
    rm ${TARGET} && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/GMSPython && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/testlib_ml && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/docs && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/C && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/CPPnet && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Data && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Fortran && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Java && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/VBA && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/C++ && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/CSharp && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Delphi && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/GAMS && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/VBnet
ARG TARGET
#
# Install GAMS Python API (but not on PyPy or CPython-3.5)
#
# python 2.6
RUN python -c "import __pypy__" 2> /dev/null || \
    [ "$(python -c'import sys;print(sys.version_info[:2])')" != "(2, 6)" ] || \
    (cd ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Python/api_26 && \
     python setup.py install > /dev/null && \
     python -c "import gams")
# python 2.7
RUN python -c "import __pypy__" 2> /dev/null || \
    [ "$(python -c'import sys;print(sys.version_info[:2])')" != "(2, 7)" ] || \
    (cd ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Python/api && \
     python setup.py install > /dev/null && \
     python -c "import gams")
# python 3.4
RUN python -c "import __pypy__" 2> /dev/null || \
    [ "$(python -c'import sys;print(sys.version_info[:2])')" != "(3, 4)" ] || \
    (cd ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Python/api_34 && \
     python setup.py install > /dev/null && \
     python -c "import gams")
# python 3.6
RUN python -c "import __pypy__" 2> /dev/null || \
    [ "$(python -c'import sys;print(sys.version_info[:2])')" != "(3, 6)" ] || \
    (cd ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Python/api_36 && \
     python setup.py install > /dev/null && \
     python -c "import gams")
ARG GAMS_DIR
