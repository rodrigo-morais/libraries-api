require "sinatra/base"
require "sinatra/reloader"
require_relative 'routes/libraries'

class LibrariesApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload './**/*.rb'
  end

  before do
    expires 200, :public, :must_revalidate
  end

  register Routing::Libraries
end


