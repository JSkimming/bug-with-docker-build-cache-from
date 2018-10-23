#!/bin/bash -eu

# function to display commands
exe() { echo; echo "\$ $*" ; "$@" ; }

echo "Run the build as one process.".
exe docker build .

exe docker image list

echo "Run the build targets separately.".

exe docker build . --target stage1 -t tag-stage1
exe docker build . --target stage2 -t tag-stage2
exe docker build . --target stage3 -t tag-stage3
exe docker build . --target stage4 -t tag-stage4

exe docker image list

echo "Run the build targets separately using cache-from.".

exe docker build . --target stage1 -t tag-stage1 \
--cache-from tag-stage1

exe docker build . --target stage2 -t tag-stage2 \
--cache-from tag-stage2 --cache-from tag-stage1

exe docker build . --target stage3 -t tag-stage3 \
--cache-from tag-stage3 --cache-from tag-stage2 --cache-from tag-stage1

exe docker build . --target stage4 -t tag-stage4 \
--cache-from tag-stage4 --cache-from tag-stage3 --cache-from tag-stage2 --cache-from tag-stage1

exe docker image list
