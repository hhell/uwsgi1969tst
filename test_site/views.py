# coding: utf8

import os
import sys
import json
import logging

from django.views.generic.base import View
from django.http import HttpResponse

from .settings import *

LOGGER = logging.getLogger(__name__)


PROCESS_STATE = {}


def test_view(request, *args, **kwargs):  # pylint: disable=unused-argument
    # Make sure the C-module is initialized:
    from . import aeotst
    aeotst.initialize()

    resp = HttpResponse('ok\n')
    return resp
