FROM java:8
ENV JRUBY_VERSION 1.7.15
RUN cd /tmp && wget http://jruby.org.s3.amazonaws.com/downloads/${JRUBY_VERSION}/jruby-bin-${JRUBY_VERSION}.tar.gz \
  && cd /opt && tar -zxvf /tmp/jruby-bin-${JRUBY_VERSION}.tar.gz \
  && rm /tmp/jruby-bin-${JRUBY_VERSION}.tar.gz
ENV PATH /opt/jruby-${JRUBY_VERSION}/bin:$PATH

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

RUN gem install bundler

CMD [ "irb" ]
