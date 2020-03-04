require File.expand_path '../../../spec_helper.rb', __FILE__

describe ".camelize" do
  context "when receives a snake case word" do
    it "returns a lower camel case word" do
      expect(Helpers::String.camelize("a_b")).to eq("aB")
    end
  end

  context "when does not receive a snake case word" do
    it "returns te same word" do
      expect(Helpers::String.camelize("ab")).to eq("ab")
    end
  end
end
