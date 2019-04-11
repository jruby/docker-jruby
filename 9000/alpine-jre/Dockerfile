FROM openjdk:8-jre-alpine

RUN apk add --no-cache \
      bash \
      libc6-compat

ENV JRUBY_VERSION 9.2.7.0
ENV JRUBY_SHA256 da7c1a5ce90015c0bafd4bca0352294e08fe1c9ec049ac51e82fe57ed50e1348

RUN apk add --no-cache --virtual .build-deps \
      curl \
      tar \
  && mkdir -p /opt/jruby \
  && curl -fSL https://repo1.maven.org/maven2/org/jruby/jruby-dist/${JRUBY_VERSION}/jruby-dist-${JRUBY_VERSION}-bin.tar.gz -o /tmp/jruby.tar.gz \
  && echo "$JRUBY_SHA256 */tmp/jruby.tar.gz" | sha256sum -c - \
  && tar -zx --strip-components=1 -f /tmp/jruby.tar.gz -C /opt/jruby \
  && rm /tmp/jruby.tar.gz \
  && ln -s /opt/jruby/bin/jruby /usr/local/bin/ruby \
  && apk del .build-deps

# set the jruby binaries in the path
ENV PATH /opt/jruby/bin:$PATH

# skip installing gem documentation
RUN mkdir -p /opt/jruby/etc \
    && { \
        echo 'install: --no-document'; \
        echo 'update: --no-document'; \
    } >> /opt/jruby/etc/gemrc

# install bundler, gem requires bash to work
RUN gem install bundler rake net-telnet xmlrpc

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
    && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

CMD [ "irb" ]
