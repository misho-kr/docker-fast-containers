#!/bin/bash
# -----------------------------------------------------------------

# set -x

MYSQL_PORT=3306
MYSQL_VERSION="5.7.5"

while getopts p:v: opt; do
  case "${opt}" in
      p ) MYSQL_PORT="${OPTARG}" ;;
      v ) MYSQL_VERSION="${OPTARG}" ;;
      * )
          echo "invalid option: -${OPTARG}" >&2
          ;;
  esac
done

shift $(( OPTIND -1 ))

# -----------------------------------------------------------------

exec \
  docker run --name=mysql -d \
    -p "${MYSQL_PORT}":3306 \
    -e MYSQL_ROOT_PASSWORD="root" \
    -e MYSQL_DATABASE="first_db" \
    -e MYSQL_USER="user" -e MYSQL_PASSWORD="password" \
    -v "${PWD}/mysql.db":/var/lib/mysql \
      mysql:"${MYSQL_VERSION}" $*

# -----------------------------------------------------------------
# eof
