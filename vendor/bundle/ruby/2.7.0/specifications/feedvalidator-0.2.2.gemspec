# -*- encoding: utf-8 -*-
# stub: feedvalidator 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "feedvalidator".freeze
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Edgar Gonzalez".freeze]
  s.date = "2019-12-29"
  s.description = "Interface to the W3C Feed Validation online service http://validator.w3.org/feed/".freeze
  s.email = ["edgargonzalez@gmail.com".freeze]
  s.homepage = "http://github.com/edgar/feedvalidator".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Interface to the W3C Feed Validation online service http://validator.w3.org/feed/".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
  end
end
