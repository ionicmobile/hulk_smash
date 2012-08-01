require_relative '../../../lib/hulk_smash/smasher'

describe HulkSmash::Smasher, 'class methods:' do
  it 'has a default number of concurrent users' do
    described_class.default_concurrent_users.should == 15
  end

  it 'has the default duration' do
    described_class.default_duration.should == '5s'
  end
end

describe HulkSmash::Smasher, 'with default options:' do
  let(:hulk_result) { mock 'parsed siege results used by hulk' }
  let(:siege_results_file) { File.expand_path('../../../../log/results.log', __FILE__) }
  let(:siege_results_contents) { mock 'results' }

  before do
    subject.stub(:`)
    File.stub(:read).with(siege_results_file).and_return(siege_results_contents)
    HulkSmash::Result.stub(:new).with(siege_results_contents).and_return(hulk_result)
  end

  describe "Running a load test" do
    it 'uses siege to run a load test against the given url' do
      siege_command = "siege -b -t5s -c15 http://localhost > #{siege_results_file} 2>&1"
      subject.should_receive(:`).with(siege_command)

      subject.run_load_test
    end

    it 'returns the result of the load test' do
      subject.run_load_test.should == hulk_result
    end
  end

  describe "Running a load test" do
    it 'uses siege to run a scalability test against the given url' do
      siege_command = "siege -t5s -c15 http://localhost > #{siege_results_file} 2>&1"
      subject.should_receive(:`).with(siege_command)

      subject.run_scalability_test
    end

    it 'returns the result of the load test' do
      HulkSmash::Result.should_receive(:new).with(siege_results_contents).and_return(hulk_result)

      subject.run_scalability_test.should == hulk_result
    end
  end
end

describe HulkSmash::Smasher, 'with custom options:' do
  subject { described_class.new url, duration: duration, concurrent_users: concurrent_users }

  let(:duration) { '1s' }
  let(:concurrent_users) { 100 }
  let(:url) { mock 'url to smash' }
  let(:hulk_result) { mock 'parsed siege results used by hulk' }
  let(:siege_results_file) { File.expand_path('../../../../log/results.log', __FILE__) }
  let(:siege_results_contents) { mock 'results' }

  before do
    subject.stub(:`)
    File.stub(:read).with(siege_results_file).and_return(siege_results_contents)
    HulkSmash::Result.stub(:new).with(siege_results_contents).and_return(hulk_result)
  end

  describe "Running a load test" do
    it 'uses siege to run a load test against the given url' do
      siege_command = "siege -b -t#{duration} -c#{concurrent_users} #{url} > #{siege_results_file} 2>&1"
      subject.should_receive(:`).with(siege_command)

      subject.run_load_test
    end

    it 'returns the result of the load test' do
      subject.run_load_test.should == hulk_result
    end
  end

  describe "Running a load test" do
    it 'uses siege to run a scalability test against the given url' do
      siege_command = "siege -t#{duration} -c#{concurrent_users} #{url} > #{siege_results_file} 2>&1"
      subject.should_receive(:`).with(siege_command)

      subject.run_scalability_test
    end

    it 'returns the result of the load test' do
      HulkSmash::Result.should_receive(:new).with(siege_results_contents).and_return(hulk_result)

      subject.run_scalability_test.should == hulk_result
    end
  end
end
