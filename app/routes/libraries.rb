require 'sinatra/json'

require_relative('../services/libraries_service')

module Routing
  module Libraries
    def self.registered(app)
      request_libraries = lambda do
        json LibrariesService.get_libraries nil
      end

      request_libraries_by_language = lambda do |language|
        json LibrariesService.get_libraries language
      end

      app.get '/libraries', &request_libraries
      app.get '/libraries/:language', &request_libraries_by_language
    end
  end
end
