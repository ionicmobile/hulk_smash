require_relative '../../../lib/hulk_smash/validator'

describe HulkSmash::Validator do
  subject { described_class.new(siege_result) }

  context 'when using a supported version of siege' do
    let(:siege_result) do
  %(
  ** SIEGE 2.71
  ** Preparing 15 concurrent users for battle.
  The server is now under siege...
  Lifting the server siege...      done.

  Transactions:		       12487 hits
  )
    end

    it 'is valid' do
      subject.should be_valid
    end
  end

  context 'when not using a supported version of siege' do
    let(:siege_result) do
  %(
  ** SIEGE 1.71
  ** Preparing 15 concurrent users for battle.
  The server is now under siege...
  Lifting the server siege...      done.

  Transactions:		       12487 hits
  )
    end

    it 'is invalid' do
      subject.should_not be_valid
    end

    it 'has reasons for why it is invalid' do
      subject.valid?
      subject.reasons_for_failure.should include("Siege version must be 2.x")
    end
  end

  context 'when the response only contains errors' do
    let(:siege_result) do
  %(
  ** SIEGE 2.71
  ** Preparing 15 concurrent users for battle.
  The server is now under siege...

  [error] socket: unable to connect sock.c:222: Connection reset by peer
  [error] socket: unable to connect sock.c:222: Connection reset by peer
  )
    end

    it 'is invalid' do
      subject.should_not be_valid
    end

    it 'contains errors' do
      subject.valid?
      subject.reasons_for_failure.should include("Unable to connect")
    end
  end  


  context 'when the response only contains errors but was successful' do
    let(:siege_result) do
  %(
** SIEGE 2.71
** Preparing 15 concurrent users for battle.
The server is now under siege...[error] socket: unable to connect sock.c:222: Connection reset by peer
[error] socket: read error Connection reset by peer sock.c:460: Connection reset by peer
    
Lifting the server siege...      done.

Transactions:		          70 hits
Availability:		       97.22 %
Elapsed time:		        4.51 secs
Data transferred:	        0.14 MB
Response time:		        0.08 secs
Transaction rate:	       15.52 trans/sec
Throughput:		        0.03 MB/sec
Concurrency:		        1.22
Successful transactions:          79
Failed transactions:	           2
Longest transaction:	        0.23
Shortest transaction:	        0.01
  )
    end

    it 'is valid' do
      subject.should be_valid
    end
  end
end
