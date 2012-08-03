module HulkSmash
  class GetRequest
    attr_reader :url, :concurrent_users, :duration
    attr_accessor :benchmark

    def initialize(url, options={})
      @url = url
      @concurrent_users = options[:concurrent_users]
      @duration = options[:duration]
      self.benchmark = options[:benchmark]
    end

    def command
      "siege #{cmd_options} #{url}"
    end

    def cmd_options
      ary = []
      ary << '-b' if benchmark
      ary << "-c#{concurrent_users}" if concurrent_users
      ary << "-t#{duration}" if duration
      ary.join(" ")
    end
  end
end
