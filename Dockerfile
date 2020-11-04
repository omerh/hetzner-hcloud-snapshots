FROM alpine:3.12.1

ARG VERSION=v1.20.0

ADD https://github.com/hetznercloud/cli/releases/download/${VERSION}/hcloud-linux-amd64.tar.gz .
RUN tar -xzf ./hcloud-linux-amd64.tar.gz \
  && mv ./hcloud /usr/local/bin
COPY backup.sh ./backup.sh

CMD [ "sh", "./backup.sh" ]
