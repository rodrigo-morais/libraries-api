require File.expand_path '../../../spec_helper.rb', __FILE__

describe "GitLab" do
  describe "#to_library" do
    let!(:git_lab) { GitLab.new }
    
    before do
      git_lab.name = 'name'
      git_lab.description = 'description'
      git_lab.web_url = 'web_url'
      git_lab.namespace_name = 'namespace_name'
    end

    it "returns an object of Library instance" do
      expect(git_lab.to_library).to be_instance_of(Library)
    end

    it "returns a Library object with all properties from GitLab object" do
      library = git_lab.to_library

      expect(library.name).to eq(git_lab.name)
      expect(library.description).to eq(git_lab.description)
      expect(library.url).to eq(git_lab.web_url)
      expect(library.user_name).to eq(git_lab.namespace_name)
    end

    it "returns a Library with a host as GitLab" do
      library = git_lab.to_library

      expect(library.host).to eq('GitLab')
    end
  end
end
