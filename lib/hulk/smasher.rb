require_relative 'result'
require 'stringio'

module Hulk
  class Smasher
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def run_load_test
      execute_siege_command "siege -t5s -b #{url}"
    end

    def run_scalability_test
      execute_siege_command "siege -t5s #{url}"
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
