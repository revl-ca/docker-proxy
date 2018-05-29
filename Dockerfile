FROM revl/docker-template:1.0.0 AS cfg
ARG SERVER_PORT="8080"
ADD nginx.conf.tpl /etc/nginx/nginx.conf.tpl
RUN ./template/tpl.py /etc/nginx/nginx.conf.tpl

FROM nginx:alpine@sha256:4a85273d1e403fbf676960c0ad41b673c7b034204a48cb32779fbb2c18e3839d
LABEL org.label-schema.description="This server proxy all GET routes to the docker.sock and deny all other HTTP method." \
      org.label-schema.name="Docker Proxy" \
      org.label-schema.schema-version="1.0.0-rc.1" \
      org.label-schema.vcs-url="https://github.com/revl-ca/docker-proxy" \
      org.label-schema.vendor="REVL" \
      org.label-schema.version="1.0.0"
EXPOSE $SERVER_PORT
COPY --from=cfg /etc/nginx/nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
