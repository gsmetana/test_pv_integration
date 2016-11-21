#!/bin/bash
# remove cmake files so travis doesn't upload entire cache every time

shopt -s nullglob

rm -fv $PV_DIR/CMakeFiles/CMakeError.log
rm -fv $PV_DIR/CMakeFiles/Makefile2
rm -fv $PV_DIR/CMakeFiles/Makefile.cmake


for f in $PV_DIR/lib/cmake/paraview-$PV_VERSION/Modules/*.cmake
do
  rm -fv $f
done
