#!/bin/bash

if [[ "$1" == --verbose ]] ; then
  verbose_mode=TRUE
  shift # remove the option from $@
else
  verbose_mode=FALSE
fi

if [[ -e source1.txt ]] ; then
  if [[ "$verbose_mode" == TRUE ]] ; then
    echo 'source1.txt exists; copying to destination.txt.'
  fi
  cp source1.txt destination.txt
elif [[ -e source2.txt ]] ; then
  if [[ "$verbose_mode" == TRUE ]] ; then
    echo 'source1.txt does not exist, but source2.txt does.'
    echo 'Copying source2.txt to destination.txt.'
  fi
  cp source2.txt destination.txt
else
  if [[ "$verbose_mode" == TRUE ]] ; then
    echo 'Neither source1.txt nor source2.txt exists; exiting.'
  fi
  exit 1 # terminate the script with a nonzero exit status (failure)
fi
