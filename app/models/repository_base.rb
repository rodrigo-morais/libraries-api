require_relative "../helpers/hash_helper"

class RepositoryBase
  class << self
    attr_accessor :uri, :query, :language
  end

  def from_hash(obj)
    Helpers::Hash::flatten_hash(obj).each do |key, value|
      self.instance_variable_set("@#{key}".to_sym, value) if self.respond_to?(key)
    end
  end
end
