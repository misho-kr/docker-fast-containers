#!/bin/bash
# -----------------------------------------------------------------

# set -x

NGINX_PORT=8080
NGINX_VERSION="1.7.12"

while getopts p:v: opt; do
  case "${opt}" in
      p ) NGINX_PORT="${OPTARG}" ;;
      v ) NGINX_VERSION="${OPTARG}" ;;
      * )
          echo "invalid option: -${OPTARG}" >&2
          ;;
  esac
done

shift $(( OPTIND -1 ))

# -----------------------------------------------------------------

exec \
  docker run --name=nginx -d -p "${NGINX_PORT}":80 \
    -v "${PWD}/nginx.dir":/usr/share/nginx:ro \
    -v "${PWD}/etc/nginx-fileserver.conf":/etc/nginx/conf.d/default.conf:ro \
      nginx:"${NGINX_VERSION}" $*

# -----------------------------------------------------------------
# eof
