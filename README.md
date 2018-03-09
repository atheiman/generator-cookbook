# Chef Generator Cookbook

[![Build Status](https://travis-ci.org/atheiman/chef-generator-cookbook.svg?branch=master)](https://travis-ci.org/atheiman/chef-generator-cookbook)

Cookbook for creating new cookbooks using [`chef generate cookbook COOKBOOK_NAME --generator-cookbook`](https://docs.chef.io/ctl_chef.html#chef-generate-cookbook):

```shell
# install `chef` utility from chef-dk if you dont already have it
gem install generator-cookbook

# generate your new cookbook using the generator repo as a template
chef generate cookbook COOKBOOK_NAME \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --generator-cookbook lib/generator-cookbook
```

Checkout [`test/desired_cookbook/`](./test/desired_cookbook/) to see how a generated cookbook will look.

## Differences from default generator

- Each generated file includes commented code to get you started
- Test-kitchen and Chefspec Travis CI setup generated
- Gemfile generated

## Notes

- This generator uses Berkshelf rather than Policyfile
- There is no Chef Delivery support

## Testing / Development

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
  --generator-cookbook ./generator_cookbook

# compare the file trees of test/desired_cookbook/ and generated_cookbook/
mkdir -p tmp
tree -a test/desired_cookbook > tmp/test/desired_cookbook.tree
tree -a generated_cookbook > tmp/generated_cookbook.tree
git diff --no-index tmp/*.tree

# diff the contents of test/desired_cookbook/ and generated_cookbook/
git diff --no-index test/desired_cookbook generated_cookbook
```

## To Do

- distribute as a gem and `chef generate cookbook` can find the generator cookbook in the gem's `lib/` dir. then use is as simple as:
```
gem install generator-cookbook
chef generate cookbook generated_cookbook \
  --generator-cookbook lib/generator-cookbook
```
- expand on generated cookbook readme
