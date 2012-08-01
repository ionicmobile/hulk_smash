module Hulk
  class Result
    attr_reader :siege_result, :avg_response_time, :requests_per_second, :errors

    def initialize(siege_result)
      @siege_result = siege_result
      parse_result
    end

    def valid?
      @errors = []
      validate_version_is_supported
      errors.empty?
    end

    def reasons_for_failure
      errors.join(", ")
    end

    private

    def parse_result
      if valid?
        parse_avg_response_time
        parse_requests_per_second
      end
    end

    def version
      regex = /\*\* SIEGE \s*([\d\.]*)$/
      @version ||= regex.match(siege_result)[1].to_f
    end

    def parse_avg_response_time
      regex = /Response time:\s*([\d\.]*) secs/
      @avg_response_time = regex.match(siege_result)[1].to_f
    end

    def parse_requests_per_second
      regex = /Transaction rate:\s*([\d\.]*) trans\/sec/
      @requests_per_second = regex.match(siege_result)[1].to_f
    end

    def validate_version_is_supported
      @errors << "Siege version must be 2.x" if version < 2 || version >= 3
    end
  end
end
