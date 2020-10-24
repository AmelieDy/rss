# Describe your gem and declare its dependencies:
$:.push File.expand_path("../lib", __FILE__)
require "feed_validator"

Gem::Specification.new do |gem|
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.summary       = %q{Interface to the W3C Feed Validation online service http://validator.w3.org/feed/}
  gem.name          = "feedvalidator"
  gem.require_paths = ["lib"]
  gem.version       = W3C::FeedValidator::VERSION
  gem.license       = "MIT"
  gem.authors       = ["Edgar Gonzalez"]
  gem.email         = ["edgargonzalez@gmail.com"]
  gem.description   = %q{Interface to the W3C Feed Validation online service http://validator.w3.org/feed/}
  gem.homepage      = "http://github.com/edgar/feedvalidator"

  gem.add_development_dependency 'rake'

  if RUBY_VERSION > '2.0.0'
    gem.add_development_dependency 'test-unit'
  end
end
