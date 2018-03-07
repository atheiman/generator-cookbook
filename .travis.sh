#!/bin/bash -ex

bundle exec chef generate cookbook generated_cookbook \
  --berks \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --verbose \
  --generator-cookbook ./code_generator

git diff --no-index desired_cookbook generated_cookbook
cd generated_cookbook
bundle
bundle exec rspec
KITCHEN_LOCAL_YAML='.kitchen.docker.yml'
bundle exec kitchen test --concurrency=2 --log-level=debug
