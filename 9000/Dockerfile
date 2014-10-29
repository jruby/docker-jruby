FROM java:8
#ENV JRUBY_VERSION cab2272ea076d2898721023c851cf895379946f2
ENV JRUBY_VERSION ea47cab70b37f01f7f7e1bc0815367cac3449f86
RUN apt-get update && apt-get install -y --no-install-recommends maven git-core \
  && git clone https://github.com/jruby/jruby.git /opt/jruby-src \
  && cd /opt/jruby-src \
  && git checkout $JRUBY_VERSION \
  && mvn -Pdist package \
  && apt-get purge -y --auto-remove maven git-core \
  && mkdir /opt/jruby \
  && mv bin /opt/jruby/ \
  && mv lib /opt/jruby/\
  && mv tool /opt/jruby/ \
  && mv samples /opt/jruby/ \
  && mv COPYING /opt/jruby/ \
  && mv LICENSE.RUBY /opt/jruby/ \
  && cd / && rm -rf /opt/jruby-src \
  && rm -rf /root/.m2 \
  && update-alternatives --install /usr/local/bin/ruby ruby /opt/jruby/bin/jruby 1
ENV PATH /opt/jruby/bin:$PATH
ENV JRUBY_OPTS -Xcompile.invokedynamic=true
