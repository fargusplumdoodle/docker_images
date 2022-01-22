FROM node:17.3.0

# Semantic Release Docker image
#
# For use in CI, run:
#   helm cm-push ./budget registry
#

ENV HELM_VERSION=3.6.3
ENV ARCH=amd64
ENV REGISTRY_HOST=https://helm.sekhnet.ra

RUN npm install --global \
    "@semantic-release/gitlab" \
    "@semantic-release/commit-analyzer" \
    "@semantic-release/release-notes-generator" \
    "@semantic-release/git" \
    "@semantic-release/exec"

# Installing helm
RUN wget https://get.helm.sh/helm-v$HELM_VERSION-linux-$ARCH.tar.gz \
    && tar xf helm-v$HELM_VERSION-linux-$ARCH.tar.gz \
    && mv ./linux-$ARCH/helm /bin/

COPY ./sekhnet-*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

RUN helm plugin install https://github.com/chartmuseum/helm-push.git  \
    && helm repo add registry $REGISTRY_HOST

CMD ["bash"]
