
require 'rubygems'
gem 'activesupport', '=2.3.5'
require 'active_support'
require 'aws'
require 'yaml'
require 'pp'
require 'pathname'
require 'fileutils'

require File.dirname(__FILE__) + '/pretty_aws/rds_instance'
require File.dirname(__FILE__) + '/pretty_aws/rds_snapshot'
require File.dirname(__FILE__) + '/pretty_aws/ext'

module PrettyAws
  class Base
    class << self
      def root
        @root ||= Pathname.new(File.expand_path('~/.pretty_aws'))
      end
      def config
        @config ||= YAML.load(File.read(root.join('pretty_aws.yml')))
      end
      def rds
        @rds ||= Aws::Rds.new(config['aws_access_key'],config['aws_secret_key'])
      end
    end
  end
end