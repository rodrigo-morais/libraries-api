require File.expand_path '../../spec_helper.rb', __FILE__

describe "Libraries" do
  data = [
    {name: 'name_1', description: 'description_1', url: 'url_1', userName: 'user_name_1', host: 'GitLab'},
    {name: 'name_2', description: 'description_2', url: 'url_2', userName: 'user_name_2', host: 'GitHub'}
  ]

  before(:each) do
    allow(LibrariesService).to receive(:get_libraries).with(nil).and_return(data)
    allow(LibrariesService).to receive(:get_libraries).with('language').and_return({})
  end

  context "get /libraries" do
    let!(:response) {get '/libraries' }

    it "returns ok" do
      expect(response).to be_ok
    end

    it "returns body" do
      expect(response.body).to eq(data.to_json)
    end
  end

  context "get /libraries/language" do
    let!(:response) {get '/libraries/language' }

    it "returns ok" do
      expect(response).to be_ok
    end

    it "returns body" do
      expect(response.body).to eq('{}')
    end
  end
end
