FROM jruby:9.0.0.0.pre1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD ADD Gemfile /usr/src/app/
ONBUILD ADD Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install --system

ONBUILD ADD . /usr/src/app
