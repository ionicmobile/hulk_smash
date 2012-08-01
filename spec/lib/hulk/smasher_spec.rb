require_relative '../../../lib/hulk/smasher'

describe Hulk::Smasher do
  subject { described_class.new url }

  let(:url) { mock 'url to smash' }
  let(:hulk_result) { mock 'parsed siege results used by hulk' }
  let(:siege_results_file) { File.expand_path('../../../../log/results.log', __FILE__) }
  let(:siege_results_contents) { mock 'results' }

  before do
    subject.stub(:`)
    File.stub(:read).with(siege_results_file).and_return(siege_results_contents)
    Hulk::Result.stub(:new).with(siege_results_contents).and_return(hulk_result)
  end

  describe "Running a load test" do
    it 'uses siege to run a load test against the given url' do
      siege_command = "siege -t5s -b #{url} > #{siege_results_file} 2>&1"
      subject.should_receive(:`).with(siege_command)

      subject.run_load_test
    end

    it 'returns the result of the load test' do
      subject.run_load_test.should == hulk_result
    end
  end

  describe "Running a load test" do
    it 'uses siege to run a scalability test against the given url' do
      siege_command = "siege -t5s #{url} > #{siege_results_file} 2>&1"
      subject.should_receive(:`).with(siege_command)

      subject.run_scalability_test
    end

    it 'returns the result of the load test' do
      Hulk::Result.should_receive(:new).with(siege_results_contents).and_return(hulk_result)

      subject.run_scalability_test.should == hulk_result
    end
  end
end
