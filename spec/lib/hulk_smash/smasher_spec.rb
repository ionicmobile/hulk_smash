require_relative '../../../lib/hulk_smash/smasher'

describe HulkSmash::Smasher do
  let(:hulk_request) { mock 'hulk request', command: siege_command }
  let(:siege_command) { mock 'siege command' }
  let(:hulk_result) { mock 'hulk result' }
  let(:siege_result_file) { File.expand_path('results.txt', cache_dir) }
  let(:cache_dir) { File.expand_path('../../../../cache', __FILE__) }
  let(:siege_result) { mock 'raw siege result' }

  before do
    Dir.stub(:exists?).with(cache_dir).and_return(true)
  end

  context 'when the cache directory does not exist' do
    before do
      Dir.stub(:exists?).with(cache_dir).and_return(false)
    end

    it 'creates the directory' do
      Dir.should_receive(:mkdir).with(cache_dir)

      subject
    end
  end

  context 'with custom values' do
    subject { described_class.new host, duration: duration, concurrent_users: concurrent_users, data: data, method: 'POST' }

    let(:host) { mock 'host' }
    let(:duration) { mock 'duration' }
    let(:concurrent_users) { mock 'concurrent_users' }
    let(:data) { mock 'data' }

    it 'creates the request using the custom values' do
      HulkSmash::Request.should_receive(:new).with(host, data: data, duration: duration, concurrent_users: concurrent_users, method: :post).and_return(hulk_request)

      subject
    end
  end

  describe 'with default options' do
    before do
      HulkSmash::Request.stub(:new).with('http://localhost', duration: '5s', concurrent_users: 15).and_return(hulk_request)
      HulkSmash::Result.stub(:new).with(siege_result).and_return(hulk_result)
      subject.stub(:`)
      File.stub(:read).with(siege_result_file).and_return(siege_result)
    end

    it 'can set the request to perform load testing' do
      hulk_request.should_receive(:benchmark=).with(true)

      subject.load_test = true
    end

    it 'can run a load test' do
      subject.should_receive(:`).with("#{siege_command} > #{siege_result_file} 2>&1")
      hulk_request.should_receive(:benchmark=).with(true)

      subject.run_load_test.should == hulk_result
    end

    it 'can run a scalability test' do
      subject.should_receive(:`).with("#{siege_command} > #{siege_result_file} 2>&1")

      subject.run_scalability_test.should == hulk_result
    end

    describe "Running the test" do
      it 'runs the siege' do
        subject.should_receive(:`).with("#{siege_command} > #{siege_result_file} 2>&1")

        subject.run
      end

      it 'returns the result of the load test' do
        subject.run

        subject.result.should == hulk_result
      end
    end

    describe "Running a load test" do
      it 'uses siege to run a scalability test against the given url' do
        subject.should_receive(:`).with("#{siege_command} > #{siege_result_file} 2>&1")

        subject.run_scalability_test
      end

      it 'returns the result of the load test' do
        subject.run_scalability_test

        subject.result.should == hulk_result
      end
    end
  end
end

describe HulkSmash::Smasher, 'class methods:' do
  it 'has a default number of concurrent users' do
    described_class.default_concurrent_users.should == 15
  end

  it 'has the default duration' do
    described_class.default_duration.should == '5s'
  end
end

