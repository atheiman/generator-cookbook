context = ChefDK::Generator.context
cookbook_dir = ::File.join(context.cookbook_root, context.cookbook_name)

silence_chef_formatter unless context.verbose

generator_desc('Ensuring correct cookbook file content')

# cookbook root dir
directory cookbook_dir

# metadata.rb
spdx_license = case context.license
               when 'apachev2'
                 'Apache-2.0'
               when 'mit'
                 'MIT'
               when 'gplv2'
                 'GPL-2.0'
               when 'gplv3'
                 'GPL-3.0'
               else
                 'All Rights Reserved'
               end

template "#{cookbook_dir}/metadata.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  variables(
    spdx_license: spdx_license
  )
  action :create_if_missing
end

# README
template "#{cookbook_dir}/README.md" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

# Berks
cookbook_file "#{cookbook_dir}/Berksfile" do
  action :create_if_missing
end

# LICENSE
template "#{cookbook_dir}/LICENSE" do
  helpers(ChefDK::Generator::TemplateHelper)
  source "LICENSE.#{context.license}.erb"
  action :create_if_missing
end

# Test Kitchen
template "#{cookbook_dir}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Inspec
directory "#{cookbook_dir}/test/integration/default" do
  recursive true
end

cookbook_file "#{cookbook_dir}/test/integration/default/default_spec.rb" do
  source 'inspec_default_spec.rb'
  action :create_if_missing
end

# Chefspec
directory "#{cookbook_dir}/spec/recipes" do
  recursive true
end

cookbook_file "#{cookbook_dir}/spec/spec_helper.rb" do
  source 'spec_helper.rb'
  action :create_if_missing
end

template "#{cookbook_dir}/spec/recipes/default_spec.rb" do
  source 'chefspec_default_spec.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Recipes
directory "#{cookbook_dir}/recipes"

cookbook_file "#{cookbook_dir}/recipes/default.rb" do
  source 'recipe.rb'
  action :create_if_missing
end

# git
if context.have_git
  unless context.skip_git_init
    generator_desc('Committing cookbook files to git')

    execute('initialize-git') do
      command('git init .')
      cwd cookbook_dir
    end
  end

  cookbook_file "#{cookbook_dir}/.gitignore" do
    source 'gitignore'
  end

  unless context.skip_git_init
    execute('git-add-new-files') do
      command('git add .')
      cwd cookbook_dir
    end

    execute('git-commit-new-files') do
      command('git commit -m "Add initial generated cookbook content"')
      cwd cookbook_dir
    end
  end
end
