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
      sphinx \
      sphinx_rtd_theme \
      cffi \
      numpy \
      mpi4py \
      sympy \
      networkx \
      Pyro4 \
      dill \
      ipython \
      openpyxl \
      pymysql \
      xlrd \
      z3-solver \
      pint \
      pyqt \
      pytest \
      pytest-qt
RUN pip install ${DOCKER_PYTHON_OPTIONAL}

# These currently fail on PyPy
ENV DOCKER_PYTHON_NOT_PYPY \
    scipy \
    matplotlib \
    pandas \
    seaborn
RUN (python -c "import __pypy__" 2> /dev/null) \
    || (pip install ${DOCKER_PYTHON_NOT_PYPY})

# These are fragile and may not work on PyPy / Python3.7
RUN pip install PyYAML || \
    pip install https://github.com/yaml/pyyaml/archive/4.1.zip || \
    echo failed to install PyYAML
RUN pip install numba || echo failed to install numba
RUN pip install pyodbc || echo failed to install pyodbc
RUN pip list
RUN (conda --version &> /dev/null && \
     conda update -n base -c defaults conda && \
     conda install -c conda-forge pymumps pynumero_libraries) || \
    echo "skipping pynumero libraries"

# These are the Python packages that should be removed to return to a
# "SLIM" build
ENV DOCKER_PYTHON_SLIM \
    ${DOCKER_PYTHON_OPTIONAL} \
    ${DOCKER_PYTHON_NOT_PYPY} \
    pyyaml \
    numba \
    pyodbc
