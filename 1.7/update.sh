#!/bin/sh

(
	set -e

	JRUBY_VERSION=$(< VERSION)
	SHA="$(curl -SLfs https://s3.amazonaws.com/jruby.org/downloads/${JRUBY_VERSION}/jruby-bin-${JRUBY_VERSION}.tar.gz.sha1)"
	SHA=$(printf '%s' ${SHA})

	for i in $(ls); do
		if [ -d "$i" ]; then
			echo setting version on "$i/Dockerfile"
			sed -i "s/ENV\ JRUBY_VERSION.*/ENV JRUBY_VERSION ${JRUBY_VERSION}/" "$i/Dockerfile"
			sed -i "s/ENV\ JRUBY_SHA1.*/ENV JRUBY_SHA1 ${SHA}/" "$i/Dockerfile"
		fi
	done

	echo versions updated to $JRUBY_VERSION @ $SHA
)
