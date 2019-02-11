
A small project for reproducing the problem of uwsgi issue #1969.

Entry point is ./run.sh which assumes Ubuntu Xenial,
it is split into ./_run_prepare.sh which installs the python and virtualenv,
and ./_run_v1.sh which starts uwsgi, does some requests and a pause to ensure
the worker rotation, and stops uwsgi.

The subject error message that should not happen is `python atexit not done yet`
from ./test_site/aeotst.pyx

For comparison, ./test_v0.py uses the same module without uwsgi.
