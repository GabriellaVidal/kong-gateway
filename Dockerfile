FROM kong
USER 0
COPY declarative/kong.yml /usr/local/etc/kong/kong.yml
LABEL description="Alpine + Kong 2.0.3 + kong-plugin-request-transformer plugin"
ENV REQUEST_TRANSFORMER=1.3.2
USER root
RUN apk update && apk add git unzip luarocks
RUN git clone https://github.com/Kong/kong-plugin-request-transformer.git \
 && cd kong-plugin-request-transformer \
 && luarocks make
RUN luarocks install kong-plugin-request-transformer
USER kong