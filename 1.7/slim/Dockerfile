FROM alpine:3.2 
ENV JRE=jre1.8.0_60 \
    JAVA_HOME=/opt/jre \
    JRUBY_VERSION=1.7.20.1 \
    JRUBY_SHA1=6a6e701a3a5769ec5d53a78660521c37da36e41f
# That's an 1.8.0_60 JRE from OpenJDK.net
# Courtesy to https://github.com/frol/docker-alpine-oraclejdk8 from where
# the setup of glibc is borrowed
RUN apk add --update wget bash ca-certificates && \
  cd /tmp && \
  wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" \
       "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" && \
  apk add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk && \
  /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
  echo 'hosts: files mdns5_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  mkdir /opt && \
  wget http://www.java.net/download/jdk8u60/archive/b18/binaries/jre-8u60-ea-bin-b18-linux-x64-02_jun_2015.tar.gz -O /tmp/${JRE}.tgz && \
  cd /opt && tar zxvf /tmp/${JRE}.tgz && \
  ln -s /opt/${JRE} /opt/jre && \
  ln -s /opt/jre/bin/java /usr/bin/java && \
  mkdir /opt/jruby \
  && wget https://s3.amazonaws.com/jruby.org/downloads/${JRUBY_VERSION}/jruby-bin-${JRUBY_VERSION}.tar.gz -O /tmp/jruby.tar.gz \
  && echo "$JRUBY_SHA1  /tmp/jruby.tar.gz" | sha1sum -c - \
  && tar -zxf /tmp/jruby.tar.gz -C /opt/jruby \
  && rm /tmp/jruby.tar.gz \
  && ln -s /opt/jruby/jruby-$JRUBY_VERSION/bin /usr/local/bin/ruby && \
  apk del wget ca-certificates && \
  cd /opt/jre/lib/amd64 && rm libjavafx_* libjfx* libfx* && \
  cd /opt/jre/lib/ && rm -rf ext/jfxrt.jar jfxswt.jar javafx.properties font* && \
  rm /tmp/* /var/cache/apk/* 

ENV PATH /opt/jruby/jruby-$JRUBY_VERSION/bin:$PATH

RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

ENV GEM_HOME /usr/local/bundle 
ENV PATH $GEM_HOME/bin:$PATH
RUN gem install bundler \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin"

              # don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME
CMD ["irb"]

