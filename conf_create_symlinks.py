#!/usr/bin/env python

import os
import os.path

IGNORE_FILES = ( 'conf_create_symlinks.py', 'conf_add.py')
SOURCE_DIR = '/home/ben/files/conf'
TARGET_DIR = '/home/ben'


entries = [f for f in os.listdir(SOURCE_DIR) if f not in IGNORE_FILES and not f.startswith('.')]

count = 0

for f in entries:
    source_path = os.path.join(SOURCE_DIR, f)
    target_path = os.path.join(TARGET_DIR, '.' + f)
    if os.path.exists(target_path):
        type = "file"
        if os.path.islink(target_path):
            type = "link"
        elif os.path.isdir(target_path):
            type = "directory"

        print "Skipping '{0}': {1} exists.".format(f, type)
    else:
        try:
            print "Linking {1} -> {0}".format(source_path, target_path)
            os.symlink(source_path, target_path)
            count += 1
        except OSError as e:
            print "Error creating sylink: {0}".format(e)


print "Created {0} symlinks in {1}".format(count, TARGET_DIR)
