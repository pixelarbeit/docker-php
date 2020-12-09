#!/bin/sh
set -e

echo "Starting crond"
crond -b -l 8

echo "Starting supervisor"
supervisord

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	echo "Starting php-fpm"
	set -- php-fpm "$@"
fi

exec "$@"
