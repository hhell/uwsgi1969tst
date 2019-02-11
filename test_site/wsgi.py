# coding: utf8

import os
import sys

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'test_site.settings')

import uwsgi


# NOTE: This is problematic with modules that don't go well with fork():
from . import aeotst
aeotst.initialize()


def uwsgi_after_fork(*args, **kwargs):
    sys.stderr.write("\n ========= test_site({}): uwsgi_after_fork.\n".format(os.getpid()))
    sys.stderr.flush()
    # Pre-initialize the C module in the current process for future use:
    from . import aeotst
    aeotst.initialize()


uwsgi.post_fork_hook = uwsgi_after_fork


from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
