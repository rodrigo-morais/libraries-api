# Libraries API

This is an API to get the last updated repositories from GitHub and GitLab.

## Endpoints

### /libraries
Returns the last 50 updated repositories from GitHub and the last 50 updated repositories from GitLab.

### /libraries/:language
Returns the last 50 updated repositories from GitHub filtered by programming language and the last 50 updated repositories from GitLab without filter.

GitHub has GraphQL endpoints which allow to filter the repositories by programming language.
GitLab has a very limited GraphQL endpoints and they don't have the option to filter by programming language. In this API we are using GitLab REST APIs which don't have an option to filter repositories by programming language.

### GitHub GraphQL Token

To access the GritHub GraphQL is necessary to add your token in the `.env` file to the attribute `GITHUB_ACCESS_TOKEN`.
Look the documentation: https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line

### How to solve the problem to filter GitLab repositories by programming language?

Using the current GitLab APIs is not efficient to filter repositories by programming language.
For example, if to have the last 50 updated GitLab repositories filter by a popular programming language we probably should first get a bigger number of repositories than 50. Let's use as example that we get the last 200 updated GitLab repositories. For every repository we have to call another endpoint to get the main programming language until we reach the the 50 with the wanted programming language. Let's say to reach the last 50 updated GitLab repositories we have to make 120 calls to get the main programming language of each repository then we will have in the end 121 API calls what will take a long time to be processed even parallelizing the calls.

One possible solution is to have a background process getting the GitLab repositories and their main programming language to save in a local database.
When this process has a good number of repositories registered then will be possible to get from GitLab endpoint the last X updated GitLab repositories and filter then by programming language using the local database. The number of repositories to be requested from GitLab endpoint is a variable and it depends how popular is a language. Even can be not possible to get the last 50 updated GitLab repositories to less popular languages.

The real solution is GitLab provide an endpoint to repositories that allow to filter by programming language.

## Extend to other hosts to code repositories

Extend the API to add new hosts is quite simple:

If the new host uses Rest API (use `GitLab` model as example):

1 - Create a new model to the host inheriting from `RepositoryBase`
2 - Inform the `uri` in the attributes
3 - Add a `to_library` method to the model to convert the `new host` to a `Library`
4 - Add a new `Thread` in the method `get_libraries` as the other current hosts

If the new host uses GraphQL API (use `GitHub` model as example):

1 - Create a new model to the host inheriting from `RepositoryBase`
2 - Inform the `uri` in the attributes
3 - Add a `query` method to return the query to the GraphQL API
4 - Add a `to_library` method to the model to convert the `new host` to a `Library`
5 - Add a new `Thread` in the method `get_libraries` as the other current hosts

## How to run the API

Build and go run with the `docker-compose`:

```
docker-compose build
docker-compose up
```

## How to execute tests

With `docker-compose` running execute:

```
docker exec libraries-api_api_1 rspec
```
