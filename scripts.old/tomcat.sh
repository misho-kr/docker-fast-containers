#!/bin/bash
# -----------------------------------------------------------------

# set -x

TOMCAT_PORT=8888
TOMCAT_VERSION="6.0.43"
TOMCAT_USERS=""

while getopts p:u:v: opt; do
  case "${opt}" in
      p ) TOMCAT_PORT="${OPTARG}" ;;
      u ) TOMCAT_USERS="${OPTARG}" ;;
      v ) TOMCAT_VERSION="${OPTARG}" ;;
      * )
          echo "invalid option: -${OPTARG}" >&2
          ;;
  esac
done

shift $(( OPTIND -1 ))

# -----------------------------------------------------------------

if [[ -z "${TOMCAT_USERS}" ]]; then
  exec \
    docker run --name=tomcat -d -p "${TOMCAT_PORT}":8080 \
      tomcat:"${TOMCAT_VERSION}" $*
else
  exec \
    docker run --name=tomcat -d -p "${TOMCAT_PORT}":8080 \
      -v "${TOMCAT_USERS}":/usr/local/tomcat/conf/tomcat-users.xml \
        tomcat:"${TOMCAT_VERSION}" $*
fi

# -----------------------------------------------------------------
# eof
