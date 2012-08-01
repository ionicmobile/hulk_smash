module Hulk
  class Validator
    attr_reader :reasons_for_failure, :siege_result

    def initialize(siege_result)
      @siege_result = siege_result
      @reasons_for_failure = []
    end

    def valid?
      validate_version_is_supported
      reasons_for_failure.empty?
    end

    private

    def version
      regex = /\*\* SIEGE \s*([\d\.]*)$/
      @version ||= regex.match(siege_result)[1].to_f
    end

    def validate_version_is_supported
      @reasons_for_failure << "Siege version must be 2.x" if version < 2 || version >= 3
    end
  end
end
