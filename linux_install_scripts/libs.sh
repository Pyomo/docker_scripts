RUN echo "" && \
    echo "======================" && \
    echo "INSTALLING COMMON LIBS" && \
    echo "======================" && \
    echo ""
RUN apt-get -q update && \
    apt-get -q -y --no-install-recommends install \
        build-essential libssl-dev libffi-dev \
        wget zip unzip \
        git subversion cmake \
        gfortran glpk-utils \
        libgfortran4 \
        libopenblas-dev \
        liblapack-dev \
        openmpi-bin openmpi-common libopenmpi-dev \
        libc6 libncurses5 libstdc++6 \
        enchant \
        unixodbc unixodbc-dev && \
    rm -rf /var/lib/apt/lists/*
