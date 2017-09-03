#!/bin/bash
DIR="sources"
pushd $DIR
  for a in `ls`
    do
      #echo $a
      echo `md5sum $a`
    done
popd
