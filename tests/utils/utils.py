"""This module contains utility functions to be used in acceptance tests."""

__author__ = "Jakub Kudzia"
__copyright__ = "Copyright (C) 2016 ACK CYFRONET AGH"
__license__ = "This software is released under the MIT license cited in " \
              "LICENSE.txt"

from environment.common import parse_json_config_file


def get_oz_cookie(config_path, oz_name, node_name=True):
    return get_cookie(config_path, oz_name, 'zone_domains', node_name)


def get_cookie(config_path, name, domain, node_name=True):
    """Reads erlang cookie from file at config path.
    node_name = True means that argument name is a node name, otherwise
    it is a domain name.
    """
    if '@' in name:
        _, _, name = name.partition('@')
    if node_name:
        domain_name = name.split(".")[1]
    else:
        domain_name = name.split(".")[0]
    config = parse_json_config_file(config_path)
    cm_config = config[domain][domain_name]['cluster_manager']
    key = list(cm_config.keys())[0]
    return str(cm_config[key]['vm.args']['setcookie'])


def hostname(erl_node):
    return erl_node.split('@')[-1]


def get_domain(node):
    if '@' in node:
        node = hostname(node)
    return node.split('.', 1)[-1]
