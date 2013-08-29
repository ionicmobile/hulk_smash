require_relative 'validator'

module HulkSmash
  class Result
    attr_reader :number_of_transactions,
                :availability,
                :elapsed_time,
                :avg_response_time,
                :requests_per_second,
                :concurrency,
                :successful_transactions,
                :failed_transactions,
                :longest_transaction,
                :shortest_transaction,
                :raw,
                :validator

    def initialize(siege_result)
      @siege_result = siege_result
      @validator = Validator.new siege_result
      @avg_response_time = 'N/A'
      @requests_per_second = 'N/A'
      @availability = 'N/A'
      @raw = 'N/A'
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
        parse_number_of_transactions
        parse_availability
        parse_elapsed_time
        parse_avg_response_time
        parse_requests_per_second
        parse_concurrency
        parse_successful_transactions
        parse_failed_transactions
        parse_longest_transaction
        parse_shortest_transaction
        parse_raw
      end
    end

    def parse_number_of_transactions
      regex = /Transactions:\s*([\d\.]*) hits/
      @number_of_transactions = regex.match(siege_result)[1]
    end

    def parse_availability
      regex = /Availability:\s*([\d\.]*) %/
      @availability = regex.match(siege_result)[1]
    end

    def parse_elapsed_time
      regex = /Elapsed time:\s*([\d\.]*) secs/
      @elapsed_time = regex.match(siege_result)[1].to_f*1000
    end

    def parse_avg_response_time
      regex = /Response time:\s*([\d\.]*) secs/
      @avg_response_time = regex.match(siege_result)[1].to_f*1000
    end

    def parse_requests_per_second
      regex = /Transaction rate:\s*([\d\.]*) trans\/sec/
      @requests_per_second = regex.match(siege_result)[1].to_f
    end

    def parse_concurrency
      regex = /Concurrency:\s*([\d\.]*)/
      @concurrency = regex.match(siege_result)[1].to_f
    end

    def parse_successful_transactions
      regex = /Successful transactions:\s*([\d\.]*)/
      @successful_transactions = regex.match(siege_result)[1].to_f
    end

    def parse_failed_transactions
      regex = /Failed transactions:\s*([\d\.]*)/
      @failed_transactions = regex.match(siege_result)[1].to_f
    end

    def parse_longest_transaction
      regex = /Longest transaction:\s*([\d\.]*)/
      @longest_transaction = regex.match(siege_result)[1].to_f*1000
    end

    def parse_shortest_transaction
      regex = /Shortest transaction:\s*([\d\.]*)/
      @shortest_transaction = regex.match(siege_result)[1].to_f*1000
    end

    def parse_raw
      @raw = siege_result
    end
  end
end
