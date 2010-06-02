Gem::Specification.new do |s|
  s.name = %q{pretty_aws}
  s.version = File.read('VERSION')
  s.authors = ["David Crockett"]
  s.date = %q{2010-03-11}
  s.description = %q{Pretty AWS}
  s.email = %q{davy@davcro.com}
	s.executables = ['rds-instances', 'rds-security-groups', 'rds-snapshots']
  s.files = Dir['lib/**/*.rb'] + Dir['bin/*']
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Davcro AWS}
  
  s.add_dependency 'aws', '2.2.6'
  s.add_dependency 'thor', '0.13.4'
  s.add_dependency 'activesupport', '2.3.5'
end