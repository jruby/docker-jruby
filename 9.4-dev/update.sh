#!/bin/bash

(
	set -e

	JRUBY_VERSION=$(< VERSION)
	JRUBY_SNAPSHOT_VERSION=${JRUBY_VERSION}-SNAPSHOT
	JRUBY_SNAPSHOT_XML=$(curl https://oss.sonatype.org/content/repositories/snapshots/org/jruby/jruby-dist/${JRUBY_SNAPSHOT_VERSION}/maven-metadata.xml)
	JRUBY_SNAPSHOT_TIMESTAMP=$(echo ${JRUBY_SNAPSHOT_XML} | xmllint --xpath "metadata/versioning/snapshot/timestamp/text()" -)
	JRUBY_SNAPSHOT_BUILDNUMBER=$(echo ${JRUBY_SNAPSHOT_XML} | xmllint --xpath "metadata/versioning/snapshot/buildNumber/text()" -)
	JRUBY_SNAPSHOT_FULLVERSION=${JRUBY_VERSION}-${JRUBY_SNAPSHOT_TIMESTAMP}-${JRUBY_SNAPSHOT_BUILDNUMBER}
	echo https://oss.sonatype.org/content/repositories/snapshots/org/jruby/jruby-dist/${JRUBY_SNAPSHOT_VERSION}/jruby-dist-${JRUBY_SNAPSHOT_FULLVERSION}-bin.tar.gz
	SHA="$(curl -fSL https://oss.sonatype.org/content/repositories/snapshots/org/jruby/jruby-dist/${JRUBY_SNAPSHOT_VERSION}/jruby-dist-${JRUBY_SNAPSHOT_FULLVERSION}-bin.tar.gz | sha256sum | awk '{print $1}')"

	for i in $(ls); do
		if [ -d "$i" ]; then
			echo setting version on "$i/Dockerfile"
			sed -i -- "s/ENV\ JRUBY_VERSION.*/ENV JRUBY_VERSION=${JRUBY_VERSION}/" "$i/Dockerfile"
			sed -i -- "s/ENV\ JRUBY_SNAPSHOT_VERSION.*/ENV JRUBY_SNAPSHOT_VERSION=${JRUBY_SNAPSHOT_VERSION}/" "$i/Dockerfile"
			sed -i -- "s/ENV\ JRUBY_SNAPSHOT_TIMESTAMP.*/ENV JRUBY_SNAPSHOT_TIMESTAMP=${JRUBY_SNAPSHOT_TIMESTAMP}/" "$i/Dockerfile"
			sed -i -- "s/ENV\ JRUBY_SNAPSHOT_BUILDNUMBER.*/ENV JRUBY_SNAPSHOT_BUILDNUMBER=${JRUBY_SNAPSHOT_BUILDNUMBER}/" "$i/Dockerfile"
			sed -i -- "s/ENV\ JRUBY_SHA256.*/ENV JRUBY_SHA256=${SHA}/" "$i/Dockerfile"
		fi
	done

	echo versions updated to $JRUBY_SNAPSHOT_FULLVERSION @ $SHA
)
