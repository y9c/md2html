#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright © 2020 Ye Chang <yech1990@gmail.com>
# Distributed under terms of the MIT license.
#
# Created: 2020-04-15 22:00


"""
Pandoc filter to convert all level 2+ headers to paragraphs with
emphasized text.
"""

from pandocfilters import toJSONFilter


def behead(key, value, format, meta):
    if key == "Header" and value[0] == 1 and "title" not in meta:
        meta["title"] = {"t": "MetaInlines", "c": value[2]}


if __name__ == "__main__":
    toJSONFilter(behead)
