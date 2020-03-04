require File.expand_path '../../../spec_helper.rb', __FILE__

describe ".from_hash" do
  class ClassRepositoryBaseUnderTest < RepositoryBase
    attr_accessor :a, :b
  end

  context "when hash has more attributes than expected" do
    it "returns CUT class with the existing attributes" do
      hash = { a: "a", b: "b", c: "c" }
      cut = ClassRepositoryBaseUnderTest.new
      cut.from_hash(hash)

      expect(cut.a).to eq("a")
      expect(cut.b).to eq("b")
      expect { cut.c }.to raise_error(NoMethodError)
    end
  end

  context "when hash has less attributes than expected" do
    it "returns CUT class with the existing attributes and nil to the ones that are not informed" do
      hash = { b: "b", c: "c" }
      cut = ClassRepositoryBaseUnderTest.new
      cut.from_hash(hash)

      expect(cut.a).to eq(nil)
      expect(cut.b).to eq("b")
      expect { cut.c }.to raise_error(NoMethodError)
    end
  end
end
