require_relative '../../../lib/hulk_smash/request'

describe HulkSmash::Request do
  subject { described_class.new host }

  let(:host) { mock 'host' }

  it 'can build a siege command' do
    subject.command.should == "siege  #{host}"
  end

  it 'can be told to perform a benchmark siege' do
    subject.benchmark = true

    subject.command.should == "siege -b #{host}"
  end

  it 'can be given a level of concurrent users to run' do
    request = described_class.new host, concurrent_users: 5

    request.command.should == "siege -c5 #{host}"
  end

  it 'can be given a duration' do
    request = described_class.new host, duration: '5s'

    request.command.should == "siege -t5s #{host}"
  end  

  it 'can be given multiple options' do
    request = described_class.new host, duration: '5s', concurrent_users: 6, benchmark: true

    request.command.should == "siege -b -c6 -t5s #{host}"
  end    
end

