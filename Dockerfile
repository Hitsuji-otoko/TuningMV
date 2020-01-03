FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev node.js vim
RUN mkdir /TuningMV
WORKDIR /TuningMV
COPY Gemfile /TuningMV/Gemfile
COPY Gemfile.lock /TuningMV/Gemfile.lock
RUN bundle install
COPY . /TuningMV
