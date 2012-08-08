#!/usr/bin/env python

import os
import os.path

IGNORE_FILES = ( 'conf_create_symlinks.py', )
SOURCE_DIR = '/home/ziarkaen/conf'
TARGET_DIR = '/home/ziarkaen'
print os.path.join(TARGET_DIR, '.', "hello")

entries = [f for f in os.listdir(SOURCE_DIR) if f not in IGNORE_FILES and not f.startswith('.')]

count = 0

for f in entries:
    full_path = os.path.join(SOURCE_DIR, f)
    try:
        os.symlink(full_path, os.path.join(TARGET_DIR, '.' + f))
        count += 1
    except OSError as e:
        print "Cannot create sylink: {0}".format(e)


print "Created {0} symlinks in {1}".format(count, TARGET_DIR)
