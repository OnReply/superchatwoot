#!/bin/bash

set -e

if [ "$CHATWOOT_PREPARE" == "true" ] ; then
  echo "Chatwoot prepare app..."
  bundle exec rails db:chatwoot_prepare
fi

echo "Starting web..."
bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0