module Helpers
  module Hash
    def self.flatten_hash(param, prefix=nil)
      param.each_pair.reduce({}) do |acc, (key, value)|
        value.is_a?(::Hash) ? acc.merge(flatten_hash(value, "#{prefix}#{key}_")) : acc.merge("#{prefix}#{key}".to_sym => value)
      end
    end
  end
end
