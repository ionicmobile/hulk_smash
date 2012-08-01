require_relative '../../../lib/hulk/smasher'

describe Hulk::Smasher do
  subject { described_class.new url }

  let(:url) { mock 'url to smash' }
  let(:siege_result) { mock 'result from the siege' }
  let(:result) { mock 'result' }

  before do
    subject.stub(:`)
  end

  describe "Running a load test" do
    before do
      subject.stub(:` => siege_result)
      Hulk::Result.stub(new: result)
    end

    it 'uses siege to run a load test against the given url' do
      siege_command = "siege -t10s -b #{url}"
      subject.should_receive(:`).with(siege_command).and_return(siege_result)

      subject.run_load_test
    end

    it 'returns the result of the load test' do
      Hulk::Result.should_receive(:new).with(siege_result).and_return(result)

      subject.run_load_test.should == result
    end
  end

  describe "Running a load test" do
    before do
      subject.stub(:` => siege_result)
      Hulk::Result.stub(new: result)
    end

    it 'uses siege to run a scalability test against the given url' do
      siege_command = "siege -t10s #{url}"
      subject.should_receive(:`).with(siege_command).and_return(siege_result)

      subject.run_scalability_test
    end

    it 'returns the result of the load test' do
      Hulk::Result.should_receive(:new).with(siege_result).and_return(result)

      subject.run_scalability_test.should == result
    end
  end
end
