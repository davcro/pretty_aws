
require 'rubygems'
require 'aws'
require 'yaml'
require 'pp'
require 'pathname'

require File.dirname(__FILE__) + '/daws/rds'
require File.dirname(__FILE__) + '/daws/ext'

module PrettyAws
  class Base
    class << self
      def root
        @root ||= Pathname.new(File.expand_path('~/.daws'))
      end
      def config
        @config ||= YAML.load(File.read(root.join('daws.yml')))
      end
      def rds
        @rds ||= Aws::Rds.new(config['aws_access_key'],config['aws_secret_key'])
      end
    end
  end
end