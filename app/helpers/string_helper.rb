module Helpers
  module String
    def self.camelize(word)
      words = word.split('_')
      words[0] + words[1..-1].collect(&:capitalize).join
    end
  end
end
