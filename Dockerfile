FROM ruby:2.3.0

MAINTAINER Jason Chaffee <jason.chaffee+docker@gmail.com>

RUN bundle config http://gems.peek.com/ peekgems:peekteamrocks5
RUN gem install foreman

ENV PATH /usr/local/bundle/bin:$PATH

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/

ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app

EXPOSE 3000

CMD ["foreman", "start"]
