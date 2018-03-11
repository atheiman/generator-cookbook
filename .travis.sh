#!/bin/bash -ex

cd test

# generate a new cookbook from installed gem
bundle exec chef generate cookbook generated_cookbook \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --verbose \
  --generator-cookbook ..

# verify generated cookbook contents
git diff --no-index desired_cookbook generated_cookbook

# verify generated cookbook tests
cd generated_cookbook
BUNDLE_GEMFILE="$(pwd)/Gemfile"
bundle
bundle exec rspec
KITCHEN_LOCAL_YAML='.kitchen.docker.yml' bundle exec kitchen test \
  --concurrency=2 \
  --log-level=debug
