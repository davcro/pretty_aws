module PrettyAws
  module ExtendRds
    
    def restore_db_instance_to_point_in_time(source,target,opts={})
      params={}
      params['SourceDBInstanceIdentifier'] = source
      params['TargetDBInstanceIdentifier'] = target
      params['UseLatestRestorableTime']=opts[:use_latest_restorable_time] if opts[:use_latest_restorable_time]
      params['DBInstanceClass']=opts[:instance_class] if opts[:instance_class]
      params['AvailabilityZone']=opts[:availability_zone] if opts[:availability_zone]
      link = do_request("RestoreDBInstanceToPointInTime", params)
    rescue Exception
      on_exception
    end
    
    def restore_db_instance_from_db_snapshot(snapshot_id, db_id, instance_class)
      params={}
      params['DBSnapshotIdentifier']=snapshot_id
      params['DBInstanceIdentifier']=db_id
      params['DBInstanceClass']=instance_class
      params['AvailabilityZone']='us-east-1a'
      link = do_request("RestoreDBInstanceFromDBSnapshot", params)
    rescue Exception
      on_exception
    end
    
    def describe_db_snapshots
      link = do_request('DescribeDBSnapshots',{},:pull_out_array=>[:describe_db_snapshots_result, :db_snapshots, :db_snapshot])
    rescue Exception
      on_exception
    end
    
    def create_db_snapshot( db_id, snapshot_id )

      params = {}
      params['DBSnapshotIdentifier'] = snapshot_id
      params['DBInstanceIdentifier'] = db_id
      link = do_request("CreateDBSnapshot", params)
    rescue Exception
      on_exception
    end
    
    def delete_db_snapshot(id)
      params = {}
      params['DBSnapshotIdentifier'] = id
      link=do_request('DeleteDBSnapshot',params)
    rescue Exception
      on_exception
    end
    
    def modify_db_instance(identifier, options={})
      params = {}
      params['DBInstanceIdentifier']=identifier
      params['DBSecurityGroups']=options[:security_groups] if options[:security_groups]
      params['AllocatedStorage']=options[:allocated_storage] if options[:allocated_storage]
      params['DBInstanceClass']=options[:instance_class] if options[:instance_class]
      params['ApplyImmediately']=options[:apply_immediately]
      link = do_request("ModifyDBInstance",params)
    rescue Exception
      on_exception
    end
    
    def revoke_db_security_group_ingress_overwrite(group_name, options={})
        params = {}
        params['DBSecurityGroupName'] = group_name
        if options[:ec2_group_name]
          params['EC2SecurityGroupName'] = options[:ec2_group_name]
          params['EC2SecurityGroupOwnerId'] = options[:ec2_group_owner_id]
        end
        if options[:cidrip]
          params['CIDRIP'] = options[:cidrip]
        end
        link = do_request("RevokeDBSecurityGroupIngress", params)
    rescue Exception
        on_exception
    end
    def authorize_db_security_group_ingress(group_name, options={})
        params = {}
        params['DBSecurityGroupName'] = group_name
        if options[:ec2_group_name]
          params['EC2SecurityGroupName'] = options[:ec2_group_name]
          params['EC2SecurityGroupOwnerId'] = options[:ec2_group_owner_id]
        end
        if options[:cidrip]
          params['CIDRIP'] = options[:cidrip]
        end
        link = do_request("AuthorizeDBSecurityGroupIngress", params)
    rescue Exception
        on_exception
    end
  end
end

Aws::Rds.class_eval do
  include PrettyAws::ExtendRds
end