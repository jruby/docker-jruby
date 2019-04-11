#!/bin/bash

(
	set -e

	JRUBY_VERSION=$(< VERSION)
	SHA="$(curl -SLfs https://repo1.maven.org/maven2/org/jruby/jruby-dist/${JRUBY_VERSION}/jruby-dist-${JRUBY_VERSION}-bin.tar.gz.sha256)"
	SHA=$(printf '%s' ${SHA})

	for i in $(ls); do
		if [ -d "$i" ]; then
			echo setting version on "$i/Dockerfile"
			sed -i "s/ENV\ JRUBY_VERSION.*/ENV JRUBY_VERSION ${JRUBY_VERSION}/" "$i/Dockerfile"
			sed -i "s/ENV\ JRUBY_SHA256.*/ENV JRUBY_SHA256 ${SHA}/" "$i/Dockerfile"
		fi
	done

	echo versions updated to $JRUBY_VERSION @ $SHA
)
