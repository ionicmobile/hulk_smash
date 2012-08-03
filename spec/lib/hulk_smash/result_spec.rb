require_relative '../../../lib/hulk_smash/result'

describe HulkSmash::Result do
  subject { described_class.new siege_result }

  let(:validator) { mock 'validator' }

  before do
    HulkSmash::Validator.stub(:new).with(siege_result).and_return(validator)
  end

  context 'when the siege results is a complete and valid result' do
    let(:siege_result) do 
  %(
  ** SIEGE 2.71
  ** Preparing 15 concurrent users for battle.
  The server is now under siege...
  Lifting the server siege...      done.

  Transactions:		       12487 hits
  Availability:		      100.00 %
  Elapsed time:		        9.41 secs
  Data transferred:	       32.19 MB
  Response time:		        0.01 secs
  Transaction rate:	     1326.99 trans/sec
  Throughput:		        3.42 MB/sec
  Concurrency:		       14.97
  Successful transactions:       12487
  Failed transactions:	           0
  Longest transaction:	        0.03
  Shortest transaction:	        0.00
  )
    end

    before do
      validator.stub(valid?: true)
    end

    it 'has an average response time in milliseconds' do
      subject.avg_response_time.should == 10
    end

    it 'has the rate of requests per second' do
      subject.requests_per_second.should == 1326.99
    end

    it 'has the availability' do
      subject.availability.should == '100.00 %'
    end
  end

  context 'when the siege results is not from siege version 2' do
    let(:siege_result) { mock 'siege result' }
    let(:reasons_for_failure) { mock 'reasons for failure' }

    before do
      validator.stub(valid?: false, reasons_for_failure: reasons_for_failure)
    end

    it 'is invalid' do
      subject.should_not be_valid
    end

    it "contains N/A for the data fields" do
      subject.avg_response_time.should == "N/A"
      subject.requests_per_second.should == "N/A"
      subject.availability.should == "N/A"
    end

    it 'contains reasons for the failure' do
      subject.reasons_for_failure.should == reasons_for_failure
    end
  end
end
