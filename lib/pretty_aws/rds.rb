module PrettyAws
  
  class Rds
    
    INSTANCE_CLASSES = [ 'db.m1.small', 'db.m1.large', 'db.m1.xlarge', 'db.m2.2xlarge', 'db.m2.4xlarge' ]
    
    def self.find(name)
      params = Base.rds.describe_db_instances.detect { |params| params[:db_instance_identifier]==name }
      new(params)
    end
    
    def self.all
      Base.rds.describe_db_instances.collect { |params| new(params) }
    end
    
    def self.wait_until(name, state)
      $stdout.printf("%-8s %-25s", "-----|"," waiting for #{name} to be #{state} ")
      while true
        begin
          item = find(name)
        rescue
          item = {:db_instance_status => nil}
        end
        if item[:db_instance_status]==state
          $stdout.puts("done")
          $stdout.flush
          return true
        else
          $stdout.print('.')
          $stdout.flush
          sleep(3)
        end
      end
    end
    
    attr_reader :params
    
    def initialize(params)
      @params=params
    end
    
    def [](name)
      @params[name]
    end
    
    def has_key?(name)
      @params.has_key?(name)
    end
    
  end
  
end