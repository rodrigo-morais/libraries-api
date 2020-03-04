require_relative '../helpers/string_helper'

class Base
  def to_hash
    hash = Hash.new
    self.instance_variables.each do |key|
      formatted_key = ::Helpers::String::camelize(key.to_s.sub("@", ""))
      hash[formatted_key] = self.instance_variable_get(key.to_sym)
    end

    hash
  end
end


