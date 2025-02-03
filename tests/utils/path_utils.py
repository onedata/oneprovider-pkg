"""This file contains utility functions for operation on file paths.
"""
__author__ = "Jakub Kudzia"
__copyright__ = "Copyright (C) 2016 ACK CYFRONET AGH"
__license__ = "This software is released under the MIT license cited in " \
              "LICENSE.txt"

import inspect
import os


def config_file(relative_file_path):
    """Returns a path to file located in {test_name}_data directory, where
    {test_name} is name of the test module that called this function.
    example: using test_utils.config_file('my_file') in my_test.py will return
    'tests/my_test_data/my_file'
    """
    caller = inspect.stack()[1]
    caller_mod = inspect.getmodule(caller[0])
    caller_mod_file_path = caller_mod.__file__
    return '{0}_data/{1}'.format(caller_mod_file_path.rstrip('.py'),
                                 relative_file_path)


def get_file_name(file_path):
    """Returns name of file, basing on file_path.
    Name is acquired by removing parent directories from file_path and stripping
    extension.
    i.e. get_file_name("dir1/dir2/file.py") will return "file"
    """
    return os.path.splitext(os.path.basename(file_path))[0]
