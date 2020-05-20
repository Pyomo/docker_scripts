import os
import argparse

base = \
"""FROM {source_image}

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# extra dependencies (over what buildpack-deps already includes)
RUN apt-get update && \
    apt-get build-dep python && \
    apt-get install -y --no-install-recommends \
		libbluetooth-dev \
		tk-dev \
		uuid-dev \
        libffi-dev \
        libgdbm-dev \
        libsqlite3-dev \
        libssl-dev \
        zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION {python_version}
ENV PYTHON_MAJOR {python_major}

RUN set -ex \
	\
	&& curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -xvzf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure \
    && make -j $(nproc) \
    && make install \
    && python${PYTHON_MAJOR} --version

RUN cd /usr/local/bin \
	&& ln -s idle${PYTHON_MAJOR} idle \
	&& ln -s pydoc${PYTHON_MAJOR} pydoc \
	&& ln -s python${PYTHON_MAJOR} python \
	&& ln -s python${PYTHON_MAJOR}-config python-config

RUN curl -O https://bootstrap.pypa.io/get-pip.py \\
    && python get-pip.py

CMD ["/bin/bash"]

"""

installs = ['linux_install_scripts/libs.sh',
            'linux_install_scripts/python_libs.sh',
            'linux_install_scripts/baron.sh',
#            'linux_install_scripts/mipcl.sh',
            'linux_install_scripts/gsl.sh',
            'linux_install_scripts/gjh.sh',
            'linux_install_scripts/gjh_asl_json.sh',
            'linux_install_scripts/gams.sh',
            'linux_install_scripts/glpk.sh',
            'linux_install_scripts/ipopt.sh',
            'linux_install_scripts/cbc.sh']
dynamic_vars_filename = '/root/dynamic_vars.out'

def create_dockerfile(source_image, python_version, python_exe, dirname):
    python_major = python_version[0]
    out = base.format(source_image=source_image)
    # if the executable is not 'python', then
    # create a symlink
    if python_exe != 'python':
        out += ('RUN ln -s "$(which {python_exe})" '
                '/usr/local/bin/python\n'.\
                format(python_exe=python_exe))
    # destination for downloaded source code
    out += "ARG PREFIX=/root\n"
    # where to place environment variables that had to be
    # determined at runtime (they will be added after the
    # initial build)
    out += ("ARG DYNAMIC_VARS_FILE="+dynamic_vars_filename+"\n")
    out += ("RUN mkdir -p ${PREFIX} && touch "+dynamic_vars_filename+"\n")
    for fname in installs:
        with open(fname) as f:
            out += f.read()
    if not os.path.exists(dirname):
        os.makedirs(dirname)
    with open(os.path.join(dirname,'Dockerfile'),'w') as f:
        f.write(out)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'source_image',
        help='The source image to start from')
    parser.add_argument(
        'python_version',
        help='The version of Python to install')
    parser.add_argument(
        'python_exe',
        help=('The name of the python executable '
              'found in the source image'))
    parser.add_argument(
        'dirname',
        help=('The name of the output directory '
              'where the Dockerfile should be placed'))
    args = parser.parse_args()
    create_dockerfile(args.source_image,
                      args.python_exe,
                      args.dirname)
