FROM eclipse-temurin:8-jdk-jammy

RUN apt-get update && apt-get install -y libc6-dev make --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV JRUBY_VERSION=9.4.13.0
ENV JRUBY_SNAPSHOT_VERSION=9.4.13.0-SNAPSHOT
ENV JRUBY_SNAPSHOT_TIMESTAMP=20250529.175042
ENV JRUBY_SNAPSHOT_BUILDNUMBER=40
ENV JRUBY_SHA256=905c60281b06c4eaa8ad659e5314a47af5b353706d6492e546348207a9374a14
RUN mkdir /opt/jruby \
  && curl -fSL https://oss.sonatype.org/content/repositories/snapshots/org/jruby/jruby-dist/${JRUBY_SNAPSHOT_VERSION}/jruby-dist-${JRUBY_VERSION}-${JRUBY_SNAPSHOT_TIMESTAMP}-${JRUBY_SNAPSHOT_BUILDNUMBER}-bin.tar.gz -o /tmp/jruby.tar.gz \
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
