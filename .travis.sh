#!/bin/bash -ex

bundle exec chef generate cookbook generated_cookbook \
  --berks \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --verbose \
  --generator-cookbook .

git diff --no-index generated_cookbook my_cookbook || true
cd generated_cookbook
bundle
bundle exec rspec
KITCHEN_LOCAL_YAML='.kitchen.docker.yml'
bundle exec kitchen test --concurrency=2 --log-level=debug

# Usage: chef generate cookbook NAME [options]
#     -b, --berks                      Generate cookbooks with berkshelf integration
#     -C, --copyright COPYRIGHT        Name of the copyright holder - defaults to 'The Authors'
#     -d, --delivery                   This option has no effect and exists only for compatibility with past releases
#     -m, --email EMAIL                Email address of the author - defaults to 'you@example.com'
#     -a, --generator-arg KEY=VALUE    Use to set arbitrary attribute KEY to VALUE in the code_generator cookbook
#     -h, --help                       Show this message
#     -I, --license LICENSE            all_rights, apachev2, mit, gplv2, gplv3 - defaults to all_rights
#         --pipeline PIPELINE          Use PIPELINE to set target branch to something other than master for the build_cookbook
#     -P, --policy                     Use policyfiles instead of Berkshelf
#     -V, --verbose                    Show detailed output from the generator
#     -v, --version                    Show chef version
#     -g GENERATOR_COOKBOOK_PATH,      Use GENERATOR_COOKBOOK_PATH for the code_generator cookbook
#         --generator-cookbook
