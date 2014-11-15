# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github/webhook/auth/version'

Gem::Specification.new do |gem|
  gem.name          = "github-webhook-auth"
  gem.version       = Github::Webhook::Auth::VERSION
  gem.authors       = ["Jon Rowe"]
  gem.email         = ["hello@jonrowe.co.uk"]
  gem.description   = %q{Simple gem for forcing a valid Github Webhook}
  gem.summary       = %q{Simple gem for forcing a valid Github Webhook}
  gem.homepage      = "https://github.com/JonRowe/github-webhook-auth.git"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

end
