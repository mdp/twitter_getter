# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twitter_getter}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Percival"]
  s.date = %q{2009-07-09}
  s.email = %q{mark@mpercival.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".gitignore",
     "README.markdown",
     "lib/twitter_getter.rb",
     "lib/twitter_getter/promiscuous_struct.rb",
     "spec/destroy_spec.rb",
     "spec/spec_helper.rb",
     "spec/test_account.sample.yaml",
     "spec/tweet_spec.rb",
     "spec/twitter_getter_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/markpercival/twitter_getter}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TwitterGetter - The Twitter API Wrapper}
  s.test_files = [
    "spec/destroy_spec.rb",
     "spec/spec_helper.rb",
     "spec/tweet_spec.rb",
     "spec/twitter_getter_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
