#!/usr/bin/env python

import os
import os.path
import sys

IGNORE_FILES = ( 'conf_create_symlinks.py', 'conf_add.py')
SOURCE_DIR = '/home/ziarkaen/conf'
TARGET_DIR = '/home/ziarkaen'

if len(sys.argv) < 2:
    exit("Supply config files to add to repo")

count = 0

for filename in sys.argv[1:]:
    if not os.path.exists(filename):
        print "{0} not found: skipping.".format(filename)
        continue
    filename = os.path.expanduser(filename)
    filename = os.path.abspath(filename)
    if not filename.startswith(TARGET_DIR):
        print "{0} not in {1}: skipping.".format(filename, TARGET_DIR)
        continue
    bare = filename[len(TARGET_DIR)+1:]
    if bare.startswith('.'):
        bare = bare[1:]
    new_filename = os.path.join(SOURCE_DIR, bare)
    if os.path.exists(new_filename):
        print "Skipping '{0}': symlink already exists.".format(filename)
        continue

    try:
        print "Moving: {0} -> {1}".format(filename, new_filename)
        os.rename(filename, new_filename)
        print "Linking {1} -> {0}".format(new_filename, filename)
        os.symlink(new_filename, filename)
        count += 1
    except OSError as e:
        print "File IO Error: {0}".format(filename)

print "Added {0} files".format(count)
