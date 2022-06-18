#!/bin/sh
SECONDS=0

set -x
cd `dirname $0/`/../
docker-compose stop
docker-compose build
docker-compose run --rm web sh -c "rails db:migrate:reset; rails db:seed; rails log:clear"
docker-compose up -d
set +x

echo Update Completed ...$SECONDS sec