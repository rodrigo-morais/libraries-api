FROM ruby:2.7
MAINTAINER @morais.rm

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
