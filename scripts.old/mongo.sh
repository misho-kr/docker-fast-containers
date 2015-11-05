#!/bin/bash
# -----------------------------------------------------------------

# set -x

MONGO_PORT=21017
MONGO_VERSION="2.6"

while getopts p:v: opt; do
  case "${opt}" in
      p ) MONGO_PORT="${OPTARG}" ;;
      v ) MONGO_VERSION="${OPTARG}" ;;
      * )
          echo "invalid option: -${OPTARG}" >&2
          ;;
  esac
done

shift $(( OPTIND -1 ))

# -----------------------------------------------------------------

exec \
  docker run --name=mongo -d -p "${MONGO_PORT}":21017 \
    -v "${PWD}/mongo.db":/data/db \
      mongo:"${MONGO_VERSION}" $*

# -----------------------------------------------------------------
# eof
