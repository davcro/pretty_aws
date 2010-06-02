task :publish do
  version = File.read('VERSION')
  puts "publishing gem pretty_aws #{version}"
  exec "gem build pretty_aws.gemspec ; gem push pretty_aws-#{version}.gem"
end

task :install do
  version = File.read('VERSION')
  exec "gem build pretty_aws.gemspec ; gem install pretty_aws-#{version}.gem --no-ri --no-rdoc"
end