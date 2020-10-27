ARG CIMG_VERSION

FROM cimg/base:$CIMG_VERSION
ARG CIMG_VERSION
ARG VCS_REF
ARG BUILD_DATE
ARG KUBECTL_VERSION

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
RUN sudo curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
RUN sudo chmod +x /usr/local/bin/kubectl