FROM eclipse-temurin:25-jre-jammy

RUN apt-get update && apt-get install -y libc6-dev make curl --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV JRUBY_VERSION=9.4.15.0
ENV JRUBY_SNAPSHOT_VERSION=9.4.15.0-SNAPSHOT
ENV JRUBY_SNAPSHOT_TIMESTAMP=20260205.051502
ENV JRUBY_SNAPSHOT_BUILDNUMBER=1
ENV JRUBY_SHA256=2f5bb8f2c6cb0b358ce5ab469fd991f5376564fc8554df51cee78659d6f422b9
RUN mkdir /opt/jruby \
  && curl -fSL https://central.sonatype.com/repository/maven-snapshots/org/jruby/jruby-dist/${JRUBY_SNAPSHOT_VERSION}/jruby-dist-${JRUBY_VERSION}-${JRUBY_SNAPSHOT_TIMESTAMP}-${JRUBY_SNAPSHOT_BUILDNUMBER}-bin.tar.gz -o /tmp/jruby.tar.gz \
  && echo "$JRUBY_SHA256 /tmp/jruby.tar.gz" | sha256sum -c - \
  && tar -zx --strip-components=1 -f /tmp/jruby.tar.gz -C /opt/jruby \
  && rm /tmp/jruby.tar.gz \
  && update-alternatives --install /usr/local/bin/ruby ruby /opt/jruby/bin/jruby 1
ENV PATH=/opt/jruby/bin:$PATH

# skip installing gem documentation
RUN mkdir -p /opt/jruby/etc \
       && { \
               echo 'install: --no-document'; \
               echo 'update: --no-document'; \
       } >> /opt/jruby/etc/gemrc

RUN gem install bundler rake net-telnet xmlrpc

# don't create ".bundle" in all our apps
ENV GEM_HOME=/usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1 \
       BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH=$GEM_HOME/bin:$PATH
# adjust permissions of a few directories for running "gem install" as an arbitrary user
RUN mkdir -p "$GEM_HOME" && chmod 777 "$GEM_HOME"

CMD [ "irb" ]

