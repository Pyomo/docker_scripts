RUN echo "" && \
    echo "==============" && \
    echo "RESTORING WGET" && \
    echo "==============" && \
    echo ""
RUN mv /usr/bin/_wget /usr/bin/wget
