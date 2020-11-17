ARG CIMG_VERSION

FROM cimg/base:$CIMG_VERSION
# Required variables
ARG CIMG_VERSION
ARG VCS_REF
ARG BUILD_DATE
ARG KUBECTL_VERSION
# Optionals
ARG ENVSUBST_VERSION=v1.2.0
ARG HELM_VERSION=v3.4.1

MAINTAINER The Spry Group, LLC. <support@spry-group.com>

# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name='spry-group/docker-cimg-kubectl' \
      org.label-schema.description='CircleCI Image with kubectl' \
      org.label-schema.vcs-url="https://github.com/spry-group/docker-cimg-kubectl" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="The Spry Group, LLC." \
      org.label-schema.version=$CIMG_VERSION-$KUBECTL_VERSION \
      org.label-schema.schema-version="1.0.0rc1"

# kubectl
# This is the primary feature of this image. The inclusion of kubectl.
RUN sudo curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
RUN sudo chmod +x /usr/local/bin/kubectl

# envsubst
# useful for interpolating environment variables into manifests.
# ex) echo manifest.yml | envsubst | kubectl apply -f -
# a8m go version is preferred since it supports defaults and provides behavior similar to bash and docker-compose with
# variable defaults.
RUN sudo curl -L https://github.com/a8m/envsubst/releases/download/${ENVSUBST_VERSION}/envsubst-`uname -s`-`uname -m` -o /usr/local/bin/envsubst
RUN sudo chmod +x /usr/local/bin/envsubst

# helm3
# Sometimes you want the full power of helm.
RUN sudo curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm-${HELM_VERSION}-linux-amd64.tar.gz
RUN sudo tar -zxzf ./helm-${HELM_VERSION}-linux-amd64.tar.gz --strip-components=1 -C /usr/local/bin linux-amd64/helm
RUN sudo chmod +x /usr/local/bin/helm

