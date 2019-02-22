RUN echo "" && \
    echo "======================" && \
    echo "INSTALLING COMMON LIBS" && \
    echo "======================" && \
    echo ""
RUN dpkg --add-architecture i386 && \
    apt-get -q update && \
    apt-get -q -y --no-install-recommends install \
        build-essential libssl-dev libffi-dev \
        wget zip unzip \
        git subversion \
        gfortran \
        libopenblas-dev \
        openmpi-bin openmpi-common libopenmpi-dev \
        libc6:i386 libncurses5:i386 libstdc++6:i386 \
        enchant \
        unixodbc unixodbc-dev && \
    rm -rf /var/lib/apt/lists/*
