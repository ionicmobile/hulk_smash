require_relative '../../../lib/hulk/smasher'

describe Hulk::Smasher do
  subject { described_class.new url }

  let(:url) { mock 'url to smash' }

  before do
    subject.stub(:`)
  end

  describe "Running a load test" do
    let(:siege_result) { mock 'result from the siege' }

    it 'uses siege to run a load test against the given url' do
      siege_command = "siege -b #{url}"
      subject.should_receive(:`).with(siege_command).and_return(siege_result)

      subject.run_load_test
    end
  end

  describe "Running a load test" do
    it 'uses siege to run a scalability test against the given url'

    it 'returns the result of the load test'
  end
end
