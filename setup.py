#!./.env/bin/python

import os
from setuptools import setup
from distutils.extension import Extension
from Cython.Build import cythonize


setup(
    name='test_site',
    packages=['test_site'],
    ext_modules=cythonize([
        Extension(
            "test_site.aeotst",
            sources=["test_site/aeotst.pyx"],
            # include_dirs=[],
            # libraries=[],
            language="c++",
        ),
    ]),
)
