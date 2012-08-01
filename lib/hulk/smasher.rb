require_relative 'result'

module Hulk
  class Smasher
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def run_load_test
      siege_result = `siege -t10s -b #{url}`
      Hulk::Result.new(siege_result)
    end

    def run_scalability_test
      siege_result = `siege -t10s #{url}`
      Hulk::Result.new(siege_result)
    end
  end
end
