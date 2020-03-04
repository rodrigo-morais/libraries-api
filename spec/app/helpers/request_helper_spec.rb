require File.expand_path '../../../spec_helper.rb', __FILE__
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow_localhost => true)

describe ".get_data" do
  address = 'https://example.com'
  response = '{"name": "name"}'

  context "when endpoint responds in 30 second or less" do
    before(:each) do
      stub_request(:get, address).
        to_return(status: 200, body: response)
    end

    it "returns data" do
      expect(RequestHelper.get_data(address)).to eq(JSON.parse(response))
    end
  end

  context "when endpoint responds in more than 30 seconds" do
    before(:each) do
      stub_request(:get, address).to_raise(Net::ReadTimeout)
    end

    it "returns data" do
      expect(RequestHelper.get_data(address)).to eq([])
    end
  end
end
