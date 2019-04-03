#!/bin/sh
#
# Simple wrapper for "gmond" and "gmetric" executables.
#
#

CMD=$1

GMOND_EXE=/usr/local/bin/gmond
GMETRIC_EXE=/usr/local/bin/gmetric
DEFAULT_CONFIG=/etc/ganglia/gmond.conf

HAS_CONFIG=false

# for gmetric
SPOOF_STRING="--spoof=$GMOND_PORT_8649_TCP_ADDR:$GMOND_PORT_8649_TCP_ADDR"


usage () {
    echo Simple wrapper for "gmond" and "gmetric" executables.
    echo
    echo Usage:
    echo "    gmond    [options]"
    echo "    gmetric  [options]"
    echo "    help"
    echo
    echo "Options:"
    echo "    -c <path>, --conf <path>      Full path of gmond.conf."
    echo "    -d <level>, --debug <level>   Debug level; [default: 0]."
    echo
    echo "    ... also other "gmond" and "gmetric" options."
    echo
}


if [ $# -lt 1 ]; then
    usage
    exit 1
fi

shift
#echo "$@"


# handle "--conf" options
for arg in "$@"; do
    if [ "$arg" = "--conf" ]; then
        HAS_CONFIG=true
    elif [ "$arg" = "-c" ]; then
        HAS_CONFIG=true
    fi
done


case "$CMD" in

    gmond)  echo "Starting gmond..."
        if [ "$HAS_CONFIG" = "true" ]; then
            exec  $GMOND_EXE  "$@"
        else
            exec  $GMOND_EXE  "$@"  "--conf"  $DEFAULT_CONFIG
        fi
        ;;

    gmetric)  echo  "Starting gmetric..."
        if [ "$HAS_CONFIG" = "true" ]; then
            exec  $GMETRIC_EXE  "$@"  $SPOOF_STRING
        else
            exec  $GMETRIC_EXE  "$@"  "--conf"  $DEFAULT_CONFIG  $SPOOF_STRING
        fi
        ;;

    help)
        usage
        ;;

    *) echo "ERROR: Invalid command line arguments."
        usage
        exit 1
        ;;
esac