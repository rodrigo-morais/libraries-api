require File.expand_path '../../../spec_helper.rb', __FILE__

describe ".flatten_hash" do
  context "when hash is nested" do
    it "returns a flatten hash" do
      nested_hash = {name: 'name', description: 'description', namespace: {name: 'namespace_name'}}
      flatten_hash = {name: 'name', description: 'description', namespace_name: 'namespace_name'}

      expect(Helpers::Hash.flatten_hash(nested_hash)).to eq(flatten_hash)
    end
  end

  context "when hash is not nested" do
    it "returns the same hash" do
      flatten_hash = {name: 'name', description: 'description', namespace_name: 'namespace_name'}

      expect(Helpers::Hash.flatten_hash(flatten_hash)).to eq(flatten_hash)
    end
  end
end
