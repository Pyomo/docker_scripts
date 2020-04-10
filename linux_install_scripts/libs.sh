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
# pypy2 is based on debian Jessie, which includes a very old cmake (3.0,
# and ampl/mp requires 3.3).  We will install a new cmake binary
RUN wget -q "https://github.com/Kitware/CMake/releases/download/v3.17.1/cmake-3.17.1-Linux-x86_64.sh" -O install_cmake.sh && \
    bash install_cmake.sh --skip-license --prefix=/ && \
    rm install_cmake.sh
