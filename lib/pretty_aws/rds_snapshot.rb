module PrettyAws
  class RdsSnapshot
    
    attr_reader :params
    
    def self.find_all_and_group
      group_by_db(all)
    end
    
    def self.all
      Base.rds.describe_db_snapshots.collect { |params| new(params) }
    end
    
    def self.group_by_db(items)
      grouped = { }
      items.each do |item|
        grouped[item.db_id] ||= [ ]
        grouped[item.db_id] << item
      end
      grouped
    end
    
    def initialize(params)
      @params=params
    end
    
    def id
      @params[:db_snapshot_identifier]
    end
    
    def storage
      @params[:allocated_storage]
    end
    
    def db_id
      @params[:db_instance_identifier]
    end
    
    def created_at
      @params[:instance_create_time]
    end
    
    def status
      @params[:status]
    end
     
  end
end

# {:status=>"creating",
#  :availability_zone=>"us-east-1a",
#  :db_snapshot_identifier=>"fidupsnapshot",
#  :engine=>"mysql5.1",
#  :instance_create_time=>"2010-04-26T03:59:18.967Z",
#  :port=>"3306",
#  :allocated_storage=>"30",
#  :db_instance_identifier=>"fidup",
#  :master_username=>"fi"}
