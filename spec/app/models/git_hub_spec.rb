require File.expand_path '../../../spec_helper.rb', __FILE__

describe "GitHub" do
  describe ".query" do
    context "when language is nil" do
      it "returns the language property with *" do
        expect(GitHub.query).to include("language:*")
      end
    end

    context "when language has value" do
      it "returns the language property with the value" do
        GitHub.language = 'ruby'

        expect(GitHub.query).to include("language:ruby")
      end
    end
  end

  describe "#to_library" do
    let!(:git_hub) { GitHub.new }
    
    before do
      git_hub.node_name = 'node_name'
      git_hub.node_description = 'node_description'
      git_hub.node_url = 'node_url'
      git_hub.node_owner_login = 'node_owner_login'
    end

    it "returns an object of Library instance" do
      expect(git_hub.to_library).to be_instance_of(Library)
    end

    it "returns a Library object with all properties from GitHub object" do
      library = git_hub.to_library

      expect(library.name).to eq(git_hub.node_name)
      expect(library.description).to eq(git_hub.node_description)
      expect(library.url).to eq(git_hub.node_url)
      expect(library.user_name).to eq(git_hub.node_owner_login)
    end

    it "returns a Library with a host as GitHub" do
      library = git_hub.to_library

      expect(library.host).to eq('GitHub')
    end
  end
end
