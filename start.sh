#!/bin/sh

bin/simple_ms_blocklist eval "SimpleMsBlocklist.Release.migrate" && \
bin/simple_ms_blocklist eval "SimpleMsBlocklist.Release.seed" && \
bin/simple_ms_blocklist start
