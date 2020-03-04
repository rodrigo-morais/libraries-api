require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app/libraries_app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() LibrariesApp end
end

RSpec.configure { |c| c.include RSpecMixin }
