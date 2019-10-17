RUN echo "" && \
    echo "======================" && \
    echo "INSTALLING PYTHON LIBS" && \
    echo "======================" && \
    echo ""
RUN pip install -U pip \
    setuptools \
    wheel \
    virtualenv \
    nose \
    coverage \
    codecov

# This picks up the packages installed above, plus any of their
# dependencies
RUN bash -c 'pip list --format freeze | cut -d= -f1 | \
    xargs echo DOCKER_PYTHON_CORE >> ${DYNAMIC_VARS_FILE}'
RUN cat ${DYNAMIC_VARS_FILE} && echo ""

ENV DOCKER_PYTHON_OPTIONAL \
    appdirs \
    ply \
    six>=1.4 \
    cffi \
    cython \
    dill \
    ipython \
    mpi4py \
    networkx \
    numpy \
    openpyxl \
    pathos \
    pint \
    pymysql \
    Pyro4 \
    pytest \
    pytest-qt \
    sphinx \
    sphinx_rtd_theme \
    sympy \
    xlrd \
    z3-solver
RUN pip install ${DOCKER_PYTHON_OPTIONAL}

# These currently fail on PyPy
ENV DOCKER_PYTHON_NOT_PYPY \
    scipy \
    matplotlib \
    pandas \
    seaborn
RUN (python -c "import __pypy__" 2> /dev/null) \
    || (pip install ${DOCKER_PYTHON_NOT_PYPY})

# These are extra packages required for Python 2.7
ENV DOCKER_PYTHON2_ADDITIONAL \
    argparse \
    unittest2 \
    ordereddict
RUN (python -c "import sys; assert sys.version_info[0]>2" 2> /dev/null) \
    || (pip install ${DOCKER_PYTHON2_ADDITIONAL}) 

# These are fragile and may not work on PyPy / Python3.7
RUN pip install PyYAML || \
    pip install https://github.com/yaml/pyyaml/archive/4.1.zip || \
    echo failed to install PyYAML
RUN pip install numba || echo failed to install numba
RUN pip install pyodbc || echo failed to install pyodbc
# Likely to fail on pypy, and python 3.x
RUN pip install PyQt4 || echo failed to install PyQt4
# Likely to fail on pypy, and python 2.x
RUN pip install PyQt5 || echo failed to install PyQt5

RUN pip list
RUN (conda --version &> /dev/null && \
     conda update -n base -c defaults conda && \
     conda install -c conda-forge pymumps pynumero_libraries) || \
    echo "skipping pynumero libraries"

