require_relative 'validator'

module Hulk
  class Result
    attr_reader :siege_result, :avg_response_time, :requests_per_second, :validator

    def initialize(siege_result)
      @siege_result = siege_result
      @validator = Validator.new siege_result
      parse_result
    end

    def valid?
      validator.valid?
    end

    def reasons_for_failure
      validator.reasons_for_failure
    end

    private

    def parse_result
      if valid?
        parse_avg_response_time
        parse_requests_per_second
      end
    end

    def parse_avg_response_time
      regex = /Response time:\s*([\d\.]*) secs/
      @avg_response_time = regex.match(siege_result)[1].to_f
    end

    def parse_requests_per_second
      regex = /Transaction rate:\s*([\d\.]*) trans\/sec/
      @requests_per_second = regex.match(siege_result)[1].to_f
    end
  end
end
