require File.expand_path '../../../spec_helper.rb', __FILE__
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow_localhost => true)

describe ".get_data" do
  address = 'https://example.com'
  result = '{"name": "name"}'
  response = "{\"data\": {\"search\": {\"edges\": #{result}}}}"

  context "when endpoint responds in 30 second or less" do
    before(:each) do
      stub_request(:post, address).
        to_return(status: 200, body: response)
    end

    it "returns data" do
      expect(GraphqlRequestHelper.get_data(address, 'query')).to eq(JSON.parse(result))
    end
  end

  context "when endpoint responds in more than 30 seconds" do
    before(:each) do
      stub_request(:post, address).
        to_raise(Net::ReadTimeout)
    end

    it "returns data" do
      expect(GraphqlRequestHelper.get_data(address, 'query')).to eq([])
    end
  end
end
