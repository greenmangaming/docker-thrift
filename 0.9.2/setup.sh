#!/bin/bash
buildDeps=" \
  automake \
  bison \
  curl \
  flex \
  g++ \
  libboost-dev \
  libboost-filesystem-dev \
  libboost-program-options-dev \
  libboost-system-dev \
  libboost-test-dev \
  libevent-dev \
  libssl-dev \
  libtool \
  make \
  pkg-config \
";

if [[ "$THRIFT_VERSION" < "0.9.3" ]]; then
  URL='http://archive.apache.org/dist/thrift'
else
  URL='http://apache.mirrors.spacedump.net/thrift'
fi

apt-get update && apt-get install -y --no-install-recommends $buildDeps && rm -rf /var/lib/apt/lists/* && \
curl -sSL "$URL/$THRIFT_VERSION/thrift-$THRIFT_VERSION.tar.gz" -o thrift.tar.gz && \
mkdir -p /usr/src/thrift && \
tar zxf thrift.tar.gz -C /usr/src/thrift --strip-components=1 && \
rm thrift.tar.gz && \
cd /usr/src/thrift && \
./configure  --without-python --without-cpp && \
make && \
make install && \
cd / && \
rm -rf /usr/src/thrift && \
curl -k -sSL "https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz" -o go.tar.gz && \
tar xzf go.tar.gz && \
rm go.tar.gz && \
cp go/bin/gofmt /usr/bin/gofmt && \
rm -rf go && \
apt-get purge -y --auto-remove $buildDeps
