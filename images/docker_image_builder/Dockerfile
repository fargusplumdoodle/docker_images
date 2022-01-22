FROM docker:20.10.12-dind

RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /bin/jq \
   && chmod +x /bin/jq


COPY ./sekhnet-*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
