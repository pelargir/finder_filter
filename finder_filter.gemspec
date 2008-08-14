Gem::Specification.new do |s|
  s.name     = "finder_filter"
  s.version  = "0.5"
  s.date     = "2008-08-14"
  s.summary  = "An easy way to add common finders to your Rails controllers."
  s.email    = "pelargir@gmail.com"
  s.homepage = "http://github.com/pelargir/finder_filter"
  s.description = "An easy way to add common finders to your Rails controllers."
  s.has_rdoc = true
  s.authors  = ["Matthew Bass"]
  s.files    = [
    "CHANGELOG",
		"README", 
		"Rakefile", 
		"finder_filter.gemspec", 
		"lib/finder_filter.rb",
		"test/test_helper.rb",
		"test/finder_filter_test.rb"
		]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]
  s.add_dependency("actionpack", ["> 2.0.1"])
  s.add_dependency("mocha", ["> 0.5.6"])
  s.add_dependency("test-spec", ["> 0.4.0"])
end