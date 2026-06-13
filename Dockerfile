ARG MADDY_VERSION

FROM ghcr.io/foxcpp/maddy:${MADDY_VERSION} AS maddy

FROM alpine:3.24

RUN set -ex && \
    apk upgrade --no-cache --available && \
    apk --no-cache add bash gopass git gnupg openssh-client

COPY --from=maddy /bin/maddy /bin/maddy

EXPOSE 25 143 993 587 465

VOLUME ["/data"]
ENTRYPOINT ["/bin/maddy", "-config", "/data/maddy.conf"]
CMD ["run"]
