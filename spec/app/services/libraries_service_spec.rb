require File.expand_path '../../../spec_helper.rb', __FILE__

describe "Libraries Service" do
  git_lab_data = [
    {name: 'name_1', description: 'description_1', web_url: 'url_1', namespace_name: 'user_name_1', host: 'GitLab'},
    {name: 'name_2', description: 'description_2', web_url: 'url_2', namespace_name: 'user_name_2', host: 'GitLab'}
  ]
  git_hub_data = [
    {node_name: 'name_3', node_description: 'description_3', node_url: 'url_3', node_owner_login: 'user_name_3', host: 'GitHub'},
    {node_name: 'name_4', node_description: 'description_4', node_url: 'url_4', node_owner_login: 'user_name_4', host: 'GitHub'}
  ]

  def get_data(git_lab_data, git_hub_data)
    git_lab = git_lab_data.map do |obj|
      repo = GitLab.new
      repo.from_hash(obj)
      repo.to_library.to_hash
    end

    git_hub = git_hub_data.map do |obj|
      repo = GitHub.new
      repo.from_hash(obj)
      repo.to_library.to_hash
    end

    git_lab.concat(git_hub)
  end

  before(:each) do
    allow(CacheHelper).to receive(:save).and_return(nil)
    allow(RequestHelper).to receive(:get_data).and_return(git_lab_data)
    allow(GraphqlRequestHelper).to receive(:get_data).and_return(git_hub_data)
  end

  context "when data comes from GitLab and GitHub APIs" do
    before(:each) do
      allow(CacheHelper).to receive(:get).and_return(nil)
    end

    it "returns GitLab and GitHub repositories" do
      expect(LibrariesService.get_libraries("")).to eq(get_data(git_lab_data, git_hub_data))
    end
  end

  context "when data comes from cache" do
    before(:each) do
      allow(CacheHelper).to receive(:get).and_return(get_data(git_lab_data, git_hub_data).to_json)
    end

    it "returns GitLab and GitHub repositories" do
      expect(LibrariesService.get_libraries("")).to eq(get_data(git_lab_data, git_hub_data))
    end
  end
end
