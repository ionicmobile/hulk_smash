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

  describe 'when it is a POST request' do
    subject { described_class.new host, method: :post, data: data }

    let(:data) { mock 'data' }
    let(:url_encoded_data) { mock 'url encoded data' }
    let(:urls_file) { File.expand_path("urls_file.txt", cache_dir) }
    let(:cache_dir) { mock 'cache dir' }
    let(:urls_file_object) { mock 'ruby file object for urls' }

    before do
      HulkSmash::UrlDataConverter.stub(:from_hash).with(data).and_return(url_encoded_data)
      HulkSmash::Smasher.stub(:cache_dir => cache_dir)
      File.stub(:open).with(urls_file, 'w+').and_return(urls_file_object)
      urls_file_object.stub(write: nil, close: nil)
    end

    it 'stores the request into a file for siege' do
      expected_url = "#{host} POST #{url_encoded_data}"

      urls_file_object.should_receive(:write).with(expected_url)
      urls_file_object.should_receive(:close)

      subject.command
    end

    it 'uses the urls file in the siege command' do
      subject.command.should == "siege  -f #{urls_file}"
    end

    
    it 'can be given multiple options' do
      subject.duration = '5s'
  
      subject.command.should == "siege -t5s -f #{urls_file}"
    end
  end

  describe 'when it is a PUT request' do
    subject { described_class.new host, method: :put, data: data }

    let(:data) { mock 'data' }
    let(:url_encoded_data) { mock 'url encoded data' }
    let(:urls_file) { File.expand_path("urls_file.txt", cache_dir) }
    let(:cache_dir) { mock 'cache dir' }
    let(:urls_file_object) { mock 'ruby file object for urls' }

    before do
      HulkSmash::UrlDataConverter.stub(:from_hash).with(data).and_return(url_encoded_data)
      HulkSmash::Smasher.stub(:cache_dir => cache_dir)
      File.stub(:open).with(urls_file, 'w+').and_return(urls_file_object)
      urls_file_object.stub(write: nil, close: nil)
    end

    it 'stores the request into a file for siege' do
      expected_url = "#{host} POST _method=put&#{url_encoded_data}"

      urls_file_object.should_receive(:write).with(expected_url)
      urls_file_object.should_receive(:close)

      subject.command
    end

    it 'uses the urls file in the siege command' do
      subject.command.should == "siege  -f #{urls_file}"
    end

    
    it 'can be given multiple options' do
      subject.duration = '5s'
  
      subject.command.should == "siege -t5s -f #{urls_file}"
    end
  end  
end

