require_relative 'result'
require_relative 'get_request'
require 'stringio'

module HulkSmash
  class Smasher
    attr_reader :request, :result

    def initialize(url='http://localhost', options={})
      options = default_options.merge(options)
      @request = GetRequest.new url, options
    end

    def load_test=(val)
      request.benchmark = val
    end

    def run_load_test
      self.load_test = true
      run
    end

    def run_scalability_test
      run
    end

    def run
      `#{request.command} > #{results_file} 2>&1`
      @result = HulkSmash::Result.new(results_file_contents)
    end

    def self.default_duration
      '5s'
    end

    def self.default_concurrent_users
      15
    end

    private

    def default_options
      { duration: '5s', concurrent_users: 15 }
    end

    def results_file
      @results_file ||= File.expand_path('../../../log/results.log', __FILE__)
    end

    def results_file_contents
      File.read(results_file)
    end
  end
end
