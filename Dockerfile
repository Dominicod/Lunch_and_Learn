FROM ruby:2.7.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /var/app

WORKDIR /var/app

COPY Gemfile /var/app/Gemfile
COPY Gemfile.lock /var/app/Gemfile.lock

RUN bundle install

CMD [ "rails", "s", "-b", "0.0.0.0" ]