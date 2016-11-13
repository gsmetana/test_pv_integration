#!/bin/bash

set -e
MAKE="make --jobs=$NUM_THREADS --keep-going"

cmake_arg_str=" -DBUILD_TESTING=0 -DBUILD_SHARED_LIBS=1  -DBUILD_EXAMPLES=0 "
pv_repo_str=""

if [ "$PV_VERSION" == "5.0" ]; then
  pv_repo_str=" --branch v5.0.0 https://github.com/Kitware/ParaView.git"
  #cmake_arg_str=" $cmake_arg_str -DVTK_WRAP_TCL=1 -DVTK_Group_Tk=1 "
  #elif [ "$PV_VERSION" == "6.3" ]; then
  #    vtk_repo_str=" --branch v6.3.0 https://github.com/Kitware/VTK.git "
  #    #cmake_arg_str=" $cmake_arg_str -DVTK_WRAP_TCL=1 -DVTK_Group_Imaging=1 -DVTK_Group_Tk=1 "
fi
if [ -d $PV_SOURCE_DIR ]; then
  echo $PV_SOURCE_DIR exists
  if [ ! -f $PV_SOURCE_DIR/CMakeLists.txt ]; then
    echo $PV_SOURCE_DIR does not contain CMakeList.txt
    rm -rf $PV_SOURCE_DIR
  fi
fi
if [ ! -d "$PV_SOURCE_DIR" ]; then
  git clone $pv_repo_str $PV_SOURCE_DIR --depth 1
  cd $PV_SOURCE_DIR
  git submodule init --depth 1
fi
mkdir -p $PV_DIR
cd $PV_DIR
cmake $cmake_arg_str $PV_SOURCE_DIR
$MAKE

