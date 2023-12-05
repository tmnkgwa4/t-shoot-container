FROM alpine:3.15.11
MAINTAINER tmnkgwa4@gmail.com

# Tool list : https://hub.docker.com/r/nicolaka/netshoot
RUN set -ex \
    && apk update \
    && apk add --no-cache \
    apache2-utils \
    aws-cli \
    bind-tools \
    bridge-utils \
    conntrack-tools \
    curl \
    drill \
    ethtool \
    file\
    fping \
    git \
    go \
    iftop \
    iperf \
    iproute2 \
    ipset \
    iptraf-ng \
    iputils \
    ipvsadm \
    jq \
    libc6-compat \
    liboping \
    make \
    mtr \
    musl-dev \
    net-snmp-tools \
    netcat-openbsd \
    nftables \
    ngrep \
    nmap \
    nmap-nping \
    openssl \
    socat \
    strace \
    tcpdump \
    tcptraceroute \
    util-linux

ENV GOPATH /root/go
ENV PATH ${GOPATH}/bin:/usr/local/go/bin:$PATH
ENV GOBIN $GOROOT/bin
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
ENV GO111MODULE=on

RUN apk update \
  && apk add --virtual build-dependencies git \
  && apk add bash curl jq \
  && go get -u github.com/fullstorydev/grpcurl \
  && go install github.com/fullstorydev/grpcurl/cmd/grpcurl \
  && rm -rf /go/pkg \
  && rm -rf /go/src \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*

# Nginx install & setting
RUN apk add --no-cache nginx && mkdir -p /run/nginx
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/tshoot-tools.conf /etc/nginx/http.d/tshoot-tools.conf
COPY app /app
COPY app1 /app1
COPY app2 /app2
COPY app3 /app3
COPY live /live
COPY ready /ready
COPY healthz /healthz
EXPOSE 3000

# Nginx startup setting
COPY startup.sh /startup.sh
RUN chmod 744 /startup.sh

ENTRYPOINT ["/bin/sh","/startup.sh"]
