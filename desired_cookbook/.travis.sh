#!/bin/bash -ex

case $SUITE in
lint)
  rubocop --lint --display-cop-names --extra-details --display-style-guide
  # foodcritic .
  ;;
chefspec)
  rspec
  ;;
*)
  KITCHEN_LOCAL_YAML='.kitchen.docker.yml' kitchen test "$SUITE" --concurrency=2 --log-level=debug
  ;;
esac
