# Chef Generator Cookbook

[![Build Status](https://travis-ci.org/atheiman/chef-generator-cookbook.svg?branch=master)](https://travis-ci.org/atheiman/chef-generator-cookbook)

Generator cookbook for creating new cookbooks using [`chef generate cookbook COOKBOOK_NAME --generator-cookbook`](https://docs.chef.io/ctl_chef.html#chef-generate-cookbook). Checkout [`test/desired_cookbook/`](./test/desired_cookbook/) to see how a generated cookbook will look.

## Usage

1. Download the cookbook available from [Chef Supermarket](https://supermarket.chef.io/cookbooks/generator-cookbook))
1. Generate a cookbook using [`chef generate cookbook ...` from `chef-dk`](https://docs.chef.io/ctl_chef.html#chef-generate-cookbook), passing in the path to this generator-cookbook as an argument

```shell
# install `chef` utility from chef-dk if you don't already have it
which chef || gem install chef-dk --no-document

# download the cookbook from the supermarket
curl -L https://supermarket.chef.io/cookbooks/generator-cookbook/download | tar xz

# generate your new cookbook using the generator repo as a template
chef generate cookbook COOKBOOK_NAME \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --generator-cookbook generator-cookbook
```

## Differences from default generator

- Each generated file includes commented code to get you started
- Test-kitchen and Chefspec Travis CI setup generated
- Gemfile generated

## Notes

- This generator uses Berkshelf rather than Policyfile
- There is no Chef Delivery support

## Development

Generating with this cookbook is tested in [Travis](https://travis-ci.org/atheiman/chef-generator-cookbook/) - a cookbook is generated and then compared to [`test/desired_cookbook`](./test/desired_cookbook/).

When developing the generator cookbook, its handy to run the generator and see if your changes work as you intended:

```shell
# clear generated_cookbook/ and generate into it
rm -rf generated_cookbook && \
  bundle exec chef generate cookbook generated_cookbook \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --verbose \
  --generator-cookbook generator-cookbook

# compare the file trees of test/desired_cookbook/ and generated_cookbook/
mkdir -p tmp
tree -a test/desired_cookbook > tmp/test/desired_cookbook.tree
tree -a generated_cookbook > tmp/generated_cookbook.tree
git diff --no-index tmp/*.tree

# diff the contents of test/desired_cookbook/ and generated_cookbook/
git diff --no-index test/desired_cookbook generated_cookbook
```

### Releasing

```shell
# once the changes have been merged into master branch
bundle exec stove
```

## To Do

- push to rubygems with travis
- push to supermarket with travis (stove most likely)
- expand on generated cookbook readme
