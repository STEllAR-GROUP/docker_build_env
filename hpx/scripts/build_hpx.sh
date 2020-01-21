#!/bin/bash -e

# Copyright (c) 2020 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FILENAME=$0
ARGS=$@

COMMAND=""
BUILD_TYPE=""
HPX_REMOTE=""
HPX_REMOTE_URL=""

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -b|--build)
            COMMAND="build"
            BUILD_TYPE="${2^}"
            shift
            shift
            ;;
        -br|--branch)
            BRANCH="$2"
            shift
            shift
            ;;
        -c|--clean)
            COMMAND="clean"
            BUILD_TYPE="${2^}"
            shift
            shift
            ;;
        -dc|--distclean)
            COMMAND="distclean"
            BUILD_TYPE="${2^}"
            shift
            shift
            ;;
        -env|--print-environment)
            PRINT_ENIRONMENT=true
            shift
            ;;
        --help)
            help
            exit 0
            shift
            ;;
        -i|--install)
            COMMAND="install"
            BUILD_TYPE="${2^}"
            shift
            shift
            ;;
        --malloc)
            MALLOC="$2"
            shift
            shift
            ;;
        -p|--pull)
            PULL=true
            shift
            ;;
        --hpx-remote)
            HPX_REMOTE="$2"
            shift
            shift
            ;;
        --hpx-remote-url)
            HPX_REMOTE_URL="$2"
            shift
            shift
            ;;
        --prefix)
            INSTALL_DIR="$2"
            shift
            shift
            ;;
        --src-path)
            SRC_PATH="$2"
            shift
            shift
            ;;
        --test)
            TEST=true
            shift
            ;;
        *) echo "Invalid argument: $1"
            exit -1
            ;;
    esac
done

if [ -z "$SRC_PATH" ]; then
    SRC_PATH=/home/$USER/src/
fi

if [ -z "$INSTALL_DIR" ]; then
    INSTALL_DIR=/home/$USER/install/hpx/$BUILD_TYPE
fi

if [ -z "$MALLOC" ]; then
    MALLOC="system"
fi

HPX_DIR=$SRC_PATH/hpx
BUILD_DIR=/home/$USER/build/hpx/$BUILD_TYPE

if [ "$COMMAND" = "" ]; then
    echo "Please provide options, see $0 --help for more info."
    exit -1
fi

if [ "$COMMAND" = "clean" ]; then
    if [ "$BUILD_TYPE" != "Debug" ] && [ "$BUILD_TYPE" != "Release" ] && [ "$BUILD_TYPE" != "RelWithDebInfo" ]; then
        echo "Invalid build type '$BUILD_TYPE'. Please pick one of the following build types:"
        echo "$0 clean [Debug, Release, RelWithDebInfo]"
        exit -1
    fi
    cd $BUILD_DIR
    echo "Cleaning hpx from $BUILD_DIR"
    make clean
    exit 0
fi

if [ "$COMMAND" = "distclean" ]; then
    if [ "$BUILD_TYPE" != "Debug" ] && [ "$BUILD_TYPE" != "Release" ] && [ "$BUILD_TYPE" != "RelWithDebInfo" ]; then
        echo "Invalid build type. Please pick one of the following build types:"
        echo "$0 distclean [Debug, Release, RelWithDebInfo]"
        exit -1
    fi
    echo "Removing $BUILD_DIR"
    rm -rf $BUILD_DIR
    echo "Removing $INSTALL_DIR"
    rm -rf $INSTALL_DIR
    exit 0
fi

build()
{
    if [ "$BUILD_TYPE" != "Debug" ] && [ "$BUILD_TYPE" != "Release" ] && [ "$BUILD_TYPE" != "RelWithDebInfo" ]; then
        echo "Invalid build type '$BUILD_TYPE'. Please pick one of the following build types:"
        echo "$0 --build [Debug, Release, RelWithDebInfo]"
        exit -1
    fi

    if [ ! -d $HPX_DIR ]; then
        git clone https://github.com/STEllAR-GROUP/hpx $HPX_DIR
    fi

    echo "HPX's build directory: $BUILD_DIR"
    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR"

    if [ ! -z "$HPX_REMOTE" ]; then
        if [ ! -z "$HPX_REMOTE_URL" ]; then
            echo "Add remote $HPX_REMOTE with url: $HPX_REMOTE_URL"
            git remote add $HPX_REMOTE $HPX_REMOTE_URL
        fi 

        git fetch $HPX_REMOTE

    fi 

    cd "$BUILD_DIR"
    if [ ! -z "$BRANCH" ]; then
        git fetch $HPX_REMOTE
        git checkout $BRANCH
    fi

    if [ "$PULL" = true ]; then
        git pull
    fi

    set -x
    cmake \
            -DCMAKE_BUILD_TYPE=$BUILD_TYPE                                      \
            -DMPI_CXX_COMPILER=mpicxx                                           \
            -DMPI_C_COMPILER=mpicc                                              \
            -DHPX_WITH_THREAD_IDLE_RATES=ON                                     \
            -DHPX_WITH_MALLOC=system                                            \
            -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR                                 \
            -DHPX_WITH_EXAMPLES=OFF                                             \
            -DHPX_WITH_VIM_YCM=ON                                               \
            -Wdev                                                               \
            $HPX_DIR
    set +x

    make -j 32 # VERBOSE=1

    if [ "$TEST" = true ]; then
        make -j 32 tests
    fi
}


install()
{
    build
    echo "Installing Phylanx in: $INSTALL_DIR"
    make -j 32 install
}

if [ "$COMMAND" = "build" ]; then
    build
fi
if [ "$COMMAND" = "install" ]; then
    install
fi
