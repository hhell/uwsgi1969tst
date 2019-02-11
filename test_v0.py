#!./.env/bin/python
# coding: utf8
"""
Non-uwsgi invocation of aeotst.
"""

from test_site import aeotst

aeotst.initialize()
print("...")
