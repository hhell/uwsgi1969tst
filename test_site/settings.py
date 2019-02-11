# coding: utf8

import os

ROOT_URLCONF = "test_site.urls"
SECRET_KEY = "..."
DEBUG = True
INSTALLED_APPS = ['test_site']

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '[%(asctime)s] (%(process)s/%(threadName)s) %(levelname)s: %(name)s: %(message)s'},
    },
    'handlers': {
        'console': {
            'level': 1,
            'class': 'logging.StreamHandler',
            'formatter': 'verbose'},
    },
    'root': {
        'handlers': ['console'],
        'level': 1,
    },
}

YT_TOKEN = open(os.path.expanduser('~/.yt/token')).read().strip()
YT_CLUSTER = 'pythia'
YT_CLI_KWARGS = dict(
    proxy=YT_CLUSTER,
    token=YT_TOKEN,
    config=dict(
        backend='rpc',
        driver_config=dict(
            cluster_url=YT_CLUSTER,
            default_select_rows_timeout=10000000)))
YT_LOGGING = dict(
    rules=[dict(
        min_level='debug',
        writers=['stderr'])],
    writers=dict(stderr=dict(type='stderr')))

TABLE = "//home/statface/webface_betaface/sbd/test.table"
