Gem::Specification.new do |s|
  s.name = %q{twitter_getter}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Percival"]
  s.date = '2009-03-30'
  s.description = 'Twitter API wrapper - super simple'
  s.email = 'mark@markpercival.us'
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt"]
  s.has_rdoc = true
  s.homepage = 'http://projects.markpercival.us/twitter_getter'
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubygems_version = '1.3.1'
  s.summary = 'simple Twitter API wrapper'

  s.add_dependency(%q<rest_client>, [">= 0.9"])
  s.add_dependency(%q<json_pure>, [">= 1.1.3"])

end