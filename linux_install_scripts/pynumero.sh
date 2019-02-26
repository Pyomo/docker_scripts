RUN echo "" && \
    echo "================================" && \
    echo "INSTALLING PYNUMERO DEPENDENCIES" && \
    echo "================================" && \
    echo ""

ARG TARGET="pynumero"
# Get Miniconda and make it the main Python interpreter
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p ~/docker_miniconda && \
    rm ~/miniconda.sh && \
    export PATH=~/docker_miniconda/bin:$PATH

# install dependencies
RUN conda install -c conda-forge pymumps && \
    conda install -c conda-forge pynumero_libraries

ARG TARGET
