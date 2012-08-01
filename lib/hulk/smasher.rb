require_relative 'result'
require 'stringio'

module Hulk
  class Smasher
    attr_reader :url, :duration

    def initialize(url='http://localhost', options={})
      options = default_options.merge(options)
      @duration = options[:duration]
      @url = url
    end

    def run_load_test
      execute_siege_command "siege -t#{duration} -b #{url}"
    end

    def run_scalability_test
      execute_siege_command "siege -t#{duration} #{url}"
    end

    private

    def default_options
      { duration: '5s' }
    end

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
