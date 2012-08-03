require_relative 'result'
require_relative 'request'

module HulkSmash
  class Smasher
    attr_reader :request, :result

    def initialize(url='http://localhost', options={})
      options = default_options.merge(options)
      options[:method] = options[:method].downcase.to_sym if options[:method]
      @request = Request.new url, options
      setup_cache_dir
    end

    def setup_cache_dir
      Dir.mkdir self.class.cache_dir unless Dir.exists?(self.class.cache_dir)
    end

    def load_test=(val)
      request.benchmark = val
    end

    def run_load_test
      self.load_test = true
      run
    end

    def run_scalability_test
      run
    end

    def run
      `#{request.command} > #{self.class.results_file} 2>&1`
      @result = HulkSmash::Result.new(self.class.results_file_contents)
    end

    def self.default_duration
      '5s'
    end

    def self.default_concurrent_users
      15
    end

    def self.cache_dir
      File.expand_path('../../../cache', __FILE__)
    end

    def self.results_file
      File.expand_path('results.txt', cache_dir)
    end

    def self.results_file_contents
      File.read(results_file) 
    end

    private

    def default_options
      { duration: '5s', concurrent_users: 15 }
    end
  end
end
