import os
import argparse

base = \
"""FROM {source_image}
CMD ["/bin/bash"]

"""

installs = ['linux_install_scripts/libs.sh',
            'linux_install_scripts/make_unsafe_wget.sh',
            'linux_install_scripts/python_libs.sh',
            'linux_install_scripts/baron.sh',
#            'linux_install_scripts/mipcl.sh',
            'linux_install_scripts/gsl.sh',
            'linux_install_scripts/gjh.sh',
            'linux_install_scripts/gjh_asl_json.sh',
            'linux_install_scripts/gams.sh',
            'linux_install_scripts/glpk.sh',
            'linux_install_scripts/ipopt.sh',
            'linux_install_scripts/cbc.sh',
            'linux_install_scripts/restore_standard_wget.sh']
dynamic_vars_filename = '/root/dynamic_vars.out'

def create_dockerfile(source_image, python_exe, dirname):
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
