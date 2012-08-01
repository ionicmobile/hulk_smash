module Hulk
  require_relative 'result'

  class Smasher
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def run_load_test
      `siege -b #{url}`
    end

    def run_scalability_test

    end
  end
end
