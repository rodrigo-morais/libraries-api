require File.expand_path '../../../spec_helper.rb', __FILE__

class FakeRedis
  def get(key)
    key
  end

  def set(key, value, expires)
    'OK'
  end
end


describe "Cache Helper" do
  fake_redis = nil

  before(:each) do
    fake_redis = FakeRedis.new
    expect(Redis).to receive(:new).and_return(fake_redis)
  end

  describe ".get" do
    it "returns the value" do
      expect(CacheHelper.get("foo")).to eq('foo')
    end

    it "calls the method #get from Redis" do
      expect(fake_redis).to receive(:get).once
      CacheHelper.get("bar")
    end
  end

  describe ".set" do
    it "returns OK" do
      expect(CacheHelper.save('foo', 'bar')).to eq('OK')
    end

    it "calls the method #set from Redis" do
      expect(fake_redis).to receive(:set).once
      CacheHelper.save('foo', 'bar')
    end
  end
end
