require_relative 'result'
require 'stringio'

module HulkSmash
  class Smasher
    attr_reader :url, :duration, :concurrent_users, :result

    def initialize(url='http://localhost', options={})
      @duration = options[:duration] || self.class.default_duration
      @concurrent_users = options[:concurrent_users] || self.class.default_concurrent_users
      @url = url
    end

    def run_load_test
      @result = execute_siege_command "siege -b -t#{duration} -c#{concurrent_users} #{url}"
    end

    def run_scalability_test
      @result = execute_siege_command "siege -t#{duration} -c#{concurrent_users} #{url}"
    end

    private

    def execute_siege_command(command)
      `#{command} > #{results_file} 2>&1`
      results = File.read(results_file)
      HulkSmash::Result.new(results)
    end

    def results_file
      @results_file ||= File.expand_path('../../../log/results.log', __FILE__)
    end

    def self.default_duration
      '5s'
    end

    def self.default_concurrent_users
      15
    end
  end
end
