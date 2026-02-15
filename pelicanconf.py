#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = "Łukasz 'utek' Bołdys"
SITENAME = "utek's thoughts"
SITEURL = "http://dev.utek.pl"

TIMEZONE = "Europe/Lisbon"

DEFAULT_LANG = "en"

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

# Blogroll
LINKS = ()

# Social widget
SOCIAL = ()

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True

PATH = "content"
THEME = "themes/uteks"
READERS = {"html": None}
PYGMENTS_RST_OPTIONS = {"linenos": "table"}


ARTICLE_URL = "{date:%Y}/{slug}/"
ARTICLE_SAVE_AS = "{date:%Y}/{slug}/index.html"
