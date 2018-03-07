# Chef Cookbook Generator

Template for creating new cookbooks with `chef generate cookbook --generator-cookbook`

```shell
# download the generator repo
curl --location \
     --silent \
     'https://github.com/atheiman/chef-cookbook-generator/archive/master.tar.gz' \
     | tar xz
# generate your new cookbook using the generator repo as a template
chef generate cookbook cookbook_name \
  --berks \
  --copyright 'Copyright Holder' \
  --email 'email@domain.com' \
  --license 'apachev2' \
  --verbose \
  --generator-cookbook chef-cookbook-generator-master
```


### To Do

- [override / monkey patch post create message](https://github.com/chef/chef-dk/blob/master/lib/chef-dk/command/generator_commands/cookbook.rb#L100)
