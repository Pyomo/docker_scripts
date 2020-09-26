RUN echo "" && \
    echo "===============" && \
    echo "OVERRIDING WGET" && \
    echo "===============" && \
    echo ""
RUN mv /usr/bin/wget /usr/bin/_wget && \
    echo '#! /bin/bash\n\
_wget --no-check-certificate $@\n\
' > /usr/bin/wget && \
    chmod a+x /usr/bin/wget
