module HulkSmash
  class Validator
    attr_reader :reasons_for_failure, :siege_result

    def initialize(siege_result)
      @siege_result = siege_result
      @reasons_for_failure = []
    end

    def valid?
      validate_version_is_supported
      validate_successful_siege
      reasons_for_failure.empty?
    end

    private

    def version
      regex = /\*\* SIEGE \s*([\d\.]*)$/
      @version ||= regex.match(siege_result)[1].to_f
    end

    def unsuccessful_siege?
      siege_result.include?('error') && !siege_result.include?('Shortest transaction')
    end

    def validate_successful_siege
      @reasons_for_failure << "Unable to connect" if unsuccessful_siege?
    end

    def validate_version_is_supported
      @reasons_for_failure << "Siege version must be 3.x" if version < 3 || version >= 4
    end
  end
end
