require_relative '../../../lib/hulk/result'

describe Hulk::Result do
  subject { described_class.new siege_result }

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

  it 'has an average response time' do
    subject.avg_response_time.should == 0.01
  end

  it 'has the rate of requests per second' do
    subject.requests_per_second.should == 1326.99
  end
end
