require_relative 'result'
require 'stringio'

module Hulk
  class Smasher
    attr_reader :url, :duration, :concurrent_users

    def initialize(url='http://localhost', options={})
      @duration = options[:duration]||'5s'
      @concurrent_users = options[:concurrent_users]||15
      @url = url
    end

    def run_load_test
      execute_siege_command "siege -b -t#{duration} -c#{concurrent_users} #{url}"
    end

    def run_scalability_test
      execute_siege_command "siege -t#{duration} -c#{concurrent_users} #{url}"
    end

    private

    def execute_siege_command(command)
      `#{command} > #{results_file} 2>&1`
      results = File.read(results_file)
      Hulk::Result.new(results)
    end

    def results_file
      @results_file ||= File.expand_path('../../../log/results.log', __FILE__)
    end
  end
end
