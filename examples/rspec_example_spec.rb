require 'hulk'

describe "A static file" do
  subject { Hulk::Smasher.new(url: "http://www.google.com/logos/2012/field_hockey-2012-hp.jpg") }

  it "can take a pretty heavy load" do
  	result = subject.run_load_test
  	(result.requests_per_second > 5000).should be_true, "Expected #{result.requests_per_second} to be greater than 5000"
  end

  it "has a very good response time" do
    result = subject.run_scalability_test
  	(result.avg_response_time < 100).should be_true, "Expected #{result.avg_response_time} to be less than 100"
  end
end


