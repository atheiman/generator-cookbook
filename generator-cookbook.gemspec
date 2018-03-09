lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name     = 'generator-cookbook'
  spec.version  = '0.1.0'
  spec.authors  = ['Austin Heiman']
  spec.email    = ['atheimanksu@gmail.com']

  spec.summary  = 'Cookbook for creating new cookbooks using `chef generate cookbook COOKBOOK_NAME --generator-cookbook`'
  spec.homepage = 'https://github.com/atheiman/chef-generator-cookbook'
  spec.license  = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'chef-dk'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'stove'
end
