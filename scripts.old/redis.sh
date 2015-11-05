#!/bin/bash
# -----------------------------------------------------------------

# set -x

REDIS_PORT=6379
REDIS_PERSISTENT="no"

while getopts p:s opt; do
  case "${opt}" in
      p ) REDIS_PORT="${OPTARG}" ;;
      s ) REDIS_PERSISTENT="yes" ;;
      * )
          echo "invalid option: -${OPTARG}" >&2
          ;;
  esac
done

shift $(( OPTIND -1 ))

# -----------------------------------------------------------------

extra_args=""

if [[ "${REDIS_PERSISTENT}" == "yes" ]]; then
  extra_args="${extra_args} --appendonly yes"
fi

# -----------------------------------------------------------------

if [[ -z "${extra_args}" ]]; then
  exec docker run --name=redis -d -p "${REDIS_PORT}":"${REDIS_PORT}" redis $*
else
  exec docker run --name=redis -d -p "${REDIS_PORT}":"${REDIS_PORT}" \
    redis redis-server ${extra_args} $*
fi

# -----------------------------------------------------------------
# eof
