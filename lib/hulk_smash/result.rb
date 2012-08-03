require_relative 'validator'

module HulkSmash
  class Result
    attr_reader :avg_response_time, :requests_per_second, :validator, :availability

    def initialize(siege_result)
      @siege_result = siege_result
      @validator = Validator.new siege_result
      @avg_response_time = 'N/A'
      @requests_per_second = 'N/A'
      @availability = 'N/A'
      parse_result
    end

    def valid?
      validator.valid?
    end

    def reasons_for_failure
      validator.reasons_for_failure
    end

    private

    def siege_result
      @siege_result
    end

    def parse_result
      if valid?
        parse_avg_response_time
        parse_requests_per_second
        parse_availability
      end
    end

    def parse_availability
      regex = /Availability:\s*([\d\.]*) %/
      @availability = regex.match(siege_result)[1] + " %"
    end

    def parse_avg_response_time
      regex = /Response time:\s*([\d\.]*) secs/
      @avg_response_time = regex.match(siege_result)[1].to_f*1000
    end

    def parse_requests_per_second
      regex = /Transaction rate:\s*([\d\.]*) trans\/sec/
      @requests_per_second = regex.match(siege_result)[1].to_f
    end
  end
end
