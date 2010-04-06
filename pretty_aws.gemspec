Gem::Specification.new do |s|
  s.name = %q{pretty_aws}
  s.version = "0.0.1"
  s.authors = ["David Crockett"]
  s.date = %q{2010-03-11}
  s.description = %q{Pretty AWS}
  s.email = %q{davy@davcro.com}
	s.executables = ['rds-instances', 'rds-security-groups']
  s.files = Dir['lib/**/*.rb'] + Dir['bin/*']
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Davcro AWS}
end