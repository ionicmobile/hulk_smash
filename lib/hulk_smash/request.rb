require_relative 'smasher'
require_relative 'url_data_converter'

module HulkSmash
  class Request
    attr_reader :url, :concurrent_users, :method, :url_data
    attr_accessor :benchmark, :duration

    def initialize(url, options={})
      @url = url
      @concurrent_users = options[:concurrent_users]
      @duration = options[:duration]
      @method = options[:method] || :get
      @url_data = UrlDataConverter.from_hash(options[:data]) if options[:data]
      self.benchmark = options[:benchmark]
    end

    def command
      if post?
        write_to_urls_file("#{url} POST #{url_data}")
        "siege #{cmd_options} -f #{urls_file}"
      elsif put?
        write_to_urls_file("#{url} POST _method=put&#{url_data}")
        "siege #{cmd_options} -f #{urls_file}"
      else
        "siege #{cmd_options} #{url}"
      end
    end

    def cmd_options
      ary = []
      ary << '-b' if benchmark
      ary << "-c#{concurrent_users}" if concurrent_users
      ary << "-t#{duration}" if duration
      ary.join(" ")
    end

    def post?
      method == :post
    end

    def put?
      method == :put
    end

    def urls_file
      File.expand_path("urls_file.txt", Smasher.cache_dir)
    end

    private

    def urls_file_base_path
      File.expand_path("../../../cache", __FILE__)
    end

    def write_to_urls_file(content)
      file = File.open(urls_file, "w+")
      file.write(content)
      file.close
    end
  end
end
