require 'lib/pretty_aws'

require 'pp'

desc 'test the gem'
task :test do
  # pp PrettyAws::Base.rds.create_db_snapshot('fidup', 'fidupsnapshot')
  PrettyAws::RdsSnapshot.all.each do |s|
    pp s.params
    puts "----"
  end
  # pp rds.describe_db_snapshots
end