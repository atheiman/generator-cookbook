# Chef Generator Cookbook

[![Build Status](https://travis-ci.org/atheiman/chef-generator-cookbook.svg?branch=master)](https://travis-ci.org/atheiman/chef-generator-cookbook)

Template for creating new cookbooks with `chef generate cookbook COOKBOOK_NAME --generator-cookbook`:

```shell
# install `chef` utility from chef-dk if you dont already have it
gem install --no-document chef-dk

# download the generator repo
curl --location \
     --silent \
     'https://github.com/atheiman/chef-generator-cookbook/archive/master.tar.gz' \
     | tar xz

# generate your new cookbook using the generator repo as a template
chef generate cookbook COOKBOOK_NAME \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --verbose \
  --generator-cookbook chef-generator-cookbook-master/generator_cookbook
```

Checkout [`desired_cookbook/`](./desired_cookbook/) to see how a generated cookbook will look.

## Differences from default generator

- Each generated file includes commented code to get you started
- Test-kitchen and Chefspec Travis CI setup generated
- Gemfile generated

## Notes

- This generator uses Berkshelf rather than Policyfile
- There is no Chef Delivery support

## Testing / Development

Generating with this cookbook is tested in [Travis](https://travis-ci.org/atheiman/chef-generator-cookbook/) - a cookbook is generated and then compared to [`desired_cookbook`](./desired_cookbook/).

When developing the generator cookbook, its handy to run the generator and see if your changes work as you intended:

```shell
# clear generated_cookbook/ and generate into it
rm -rf generated_cookbook && \
  bundle exec chef generate cookbook generated_cookbook \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --verbose \
  --generator-cookbook ./generator_cookbook

# compare the file trees of desired_cookbook/ and generated_cookbook/
mkdir -p tmp
tree -a desired_cookbook > tmp/desired_cookbook.tree
tree -a generated_cookbook > tmp/generated_cookbook.tree
git diff --no-index tmp/*.tree

# diff the contents of desired_cookbook/ and generated_cookbook/
git diff --no-index desired_cookbook generated_cookbook
```

## To Do

- [override / monkey patch post create message](https://github.com/chef/chef-dk/blob/master/lib/chef-dk/command/generator_commands/cookbook.rb#L100)
