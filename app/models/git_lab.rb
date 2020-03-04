require_relative 'repository_base'
require_relative 'library'

class GitLab < RepositoryBase
  @uri = 'https://gitlab.com/api/v4/projects?visibility=public&order_by=last_activity_at&per_page=50'
  attr_accessor :name, :description, :web_url, :namespace_name

  def to_library
    library = Library.new

    library.name = @name
    library.description = @description
    library.url = @web_url
    library.user_name = @namespace_name
    library.host = 'GitLab'

    library
  end
end
