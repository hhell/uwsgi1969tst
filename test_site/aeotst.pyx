# coding: utf8
# cython: language_level=2

# https://github.com/cython/cython/blob/master/Cython/Includes/libc/stdlib.pxd
from libc.stdio cimport stderr, fprintf, fflush
from libc.stdlib cimport atexit as stdlib_atexit
import sys
import atexit as py_atexit

cdef bint INIT_DONE = 0;
cdef bint PYTHON_EXISTS = 0;


cdef void debug_write_c(const char *line) nogil:
    fprintf(stderr, "======== ")
    # fprintf(stderr, "%s", timestamp())
    fprintf(stderr, " aeotst(c): ")
    fprintf(stderr, "%s", line)
    fprintf(stderr, "\n")
    fflush(stderr)


def debug_write_py(line):
    try:
        sys.stderr.write("======== ")
        # sys.stderr.write(datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.%f"))
        sys.stderr.write(" aeotst(p): ")
        sys.stderr.write(line)
        sys.stderr.write("\n")
        sys.stderr.flush()
    except Exception:
        pass


def on_py_atexit():
    debug_write_py("on_python_atexit().")
    global PYTHON_EXISTS
    PYTHON_EXISTS = 0


cdef void on_stdlib_atexit() nogil:
    debug_write_c("on_stdlib_atexit().")
    if PYTHON_EXISTS != 0:
        debug_write_c("ERROR: python atexit not done yet.")


def initialize():
    global INIT_DONE
    global PYTHON_EXISTS

    if INIT_DONE == 1:
        return

    debug_write_c("initialize.\n")


    py_atexit.register(on_py_atexit)
    stdlib_atexit(on_stdlib_atexit)

    PYTHON_EXISTS = 1
    INIT_DONE = 1
