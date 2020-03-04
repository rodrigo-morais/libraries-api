require_relative "../models/git_hub"
require_relative "../models/git_lab"
require_relative "../helpers/graphql_request_helper"
require_relative "../helpers/request_helper"
require_relative "../helpers/cache_helper"

class LibrariesService
  def self.get_libraries(language)
    key = "libraries#{language.nil? ? '' : '/' + language}"
    repos = CacheHelper.get(key)

    if repos.nil?
      repos = []
      threads = [
        Thread.new { get_repositories(GitLab, language, RequestHelper) },
        Thread.new { get_repositories(GitHub, language, GraphqlRequestHelper) },
      ]

      threads.each do |t|
        t.join
        repos.concat(t.value)
      end

      CacheHelper.save(key, repos.to_json)

      repos
    else
      JSON.parse(repos)
    end

  end

private
  def self.get_repositories(repository, language, request)
    repository.language = language

    repos = request.get_data(repository.uri, repository.query).map do |obj|
      repo = repository.new
      repo.from_hash(obj)

      repo.to_library.to_hash
    end

    repos
  end
end
