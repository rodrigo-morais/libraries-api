require_relative 'repository_base'
require_relative 'library'

class GitHub < RepositoryBase
  @uri = 'https://api.github.com/graphql'
  attr_accessor :node_name, :node_description, :node_url, :node_owner_login

  def self.query
    "{\"query\":\"{ search(query: \\\"is:public sort:updated-desc language:#{@language.nil? ? '*' : @language}\\\", type: REPOSITORY, first: 50) { edges { node { ... on Repository { name description url owner{login}}}}}}\"}"
  end

  def to_library
    library = Library.new

    library.name = @node_name
    library.description = @node_description
    library.url = @node_url
    library.user_name = @node_owner_login
    library.host = 'GitHub'

    library
  end
end
