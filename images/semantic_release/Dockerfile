FROM node:17.3.0

# Semantic Release Docker image
#
# For use in CI, run:
#   helm cm-push ./budget registry
#

ENV HELM_VERSION=3.7.2
ENV ARCH=amd64

RUN npm install --global \
    "semantic-release" \
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

RUN helm plugin install https://github.com/chartmuseum/helm-push.git

CMD ["bash"]
