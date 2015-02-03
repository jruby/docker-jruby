FROM jruby:1.7-jdk

# Note that we `ADD .` **after** calling `bundle install`.
# This pattern is taken from the official ruby-onbuild image.
# It is this way is to make the most effective use of the build cache.
# Putting `ADD .` before `bundle install` would be simpler, but then any change
# in `.` would cause `bundle install` to run again, which is undesirable.

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD ADD Gemfile /usr/src/app/
ONBUILD ADD Gemfile.lock /usr/src/app/
ONBUILD ADD *.gemspec .gemspec* /usr/src/app/
ONBUILD RUN bundle install --system

ONBUILD ADD . /usr/src/app
