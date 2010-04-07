module PrettyAws
  
  class NotFound < StandardError; end
  class RdsInstance
    
    INSTANCE_CLASSES = [ 'db.m1.small', 'db.m1.large', 'db.m1.xlarge', 'db.m2.2xlarge', 'db.m2.4xlarge' ]
    
    def self.find(name)
      params = Base.rds.describe_db_instances.detect { |params| params[:db_instance_identifier]==name }
      if params.nil?
        raise PrettyAws::NotFound
      end
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
    
    def self.create(params={})
      required_params = [ :name, :instance_class, :storage, :username, :password ]
      required_params.each { |key| raise "#{key} required" unless params.has_key?(key) }
      Base.rds.create_db_instance(
        params[:name], 
        params[:instance_class], 
        params[:storage], 
        params[:username],
        params[:password],
        :availability_zone => 'us-east-1a'
      )
      RdsInstance.wait_until(params[:name], 'available')
    end
    
    def self.delete(name)
      Base.rds.delete_db_instance(name)
    end
    
    attr_reader :params
    
    def initialize(params)
      @params=params
    end
    
    def name
      @params[:db_instance_identifier]
    end
    
    def status
      @params[:db_instance_status]
    end
    
    def address
      if @params.has_key?(:endpoint) and @params[:endpoint].is_a?(Hash) and @params[:endpoint].has_key?(:address)
        @address = @params[:endpoint][:address]
      else
        @address = nil
      end
      @address
    end
    
    def cpu_size
      @params[:db_instance_class]
    end
    
    def storage
      @params[:allocated_storage]
    end
    
    def zone
      @params[:availability_zone]
    end
    
    def username
      @params[:master_username]
    end
    
    def engine
      @params[:engine]
    end
    
    def security_groups
      security_groups = [ ]
      item[:db_security_groups].each do |group|
        p('', '', group[:db_security_group_name], group[:status])
      end
    end
    
    def created_at
      @params[:instance_create_time]
    end
    
    def restorable_at
      @params[:latest_restorable_time]
    end
    
    def backup_period
      @params[:backup_retention_period]
    end
    
    def backup_window
      @params[:preferred_backup_window]
    end
    
    def mod_window
      @params[:preferred_maintenance_window]
    end
    
    def [](name)
      @params[name]
    end
    
    def has_key?(name)
      @params.has_key?(name)
    end
    
  end
  
end