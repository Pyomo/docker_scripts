RUN echo "" && \
    echo "===============" && \
    echo "INSTALLING GAMS" && \
    echo "===============" && \
    echo ""
ARG TARGET="linux_x64_64_sfx.exe"
ARG GAMS_DIR="gams29.1_linux_x64_64_sfx"
ENV GAMS_VERSION="29.1.0"
ENV PATH="${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}:${PATH}"
ENV LD_LIBRARY_PATH="${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}:${LD_LIBRARY_PATH}"
# Note that removing GMSPython causes newer versions (certainly 29.1.0)
# to fail to run
RUN mkdir ${PREFIX}/GAMS_${GAMS_VERSION} && \
    cd ${PREFIX}/GAMS_${GAMS_VERSION} && \
    wget -q "https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMS_VERSION}/linux/${TARGET}" && \
    chmod u+x ${TARGET} && \
    ./${TARGET} > /dev/null && \
    rm ${TARGET} && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/finlib_ml && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/testlib_ml && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/docs && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/mccarl && \
    rm -r ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/studio && \
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
RUN ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/gams
#
# Install GAMS Python API (but not on PyPy or CPython-3.5)
#
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
# python 3.7
RUN python -c "import __pypy__" 2> /dev/null || \
    [ "$(python -c'import sys;print(sys.version_info[:2])')" != "(3, 7)" ] || \
    (cd ${PREFIX}/GAMS_${GAMS_VERSION}/${GAMS_DIR}/apifiles/Python/api_37 && \
     python setup.py install > /dev/null && \
     python -c "import gams")
ARG GAMS_DIR
