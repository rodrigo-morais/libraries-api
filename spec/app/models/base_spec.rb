require File.expand_path '../../../spec_helper.rb', __FILE__



describe ".to_hash" do
  class ClassBaseUnderTest < Base
    attr_accessor :a, :b
  end

  it "returns a has with all CUT attributes" do
    hash = { "a" => "a", "b" => "b" }
    cut = ClassBaseUnderTest.new
    cut.a = "a"
    cut.b = "b"

    expect(cut.to_hash).to eq(hash)
  end
end
