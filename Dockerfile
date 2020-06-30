FROM alpine
RUN apk add --no-cache certbot
ARG TZ="Asia/Shanghai"
# process wrapper
LABEL maintainer "sebs sebsclub@outlook.com"
ENV TROJAN_VERSION 1.16.0 
ENV TROJAN_CONFIG_DIR /etc/trojan/
ENV V2RAY_DOWNLOAD_URL https://github.com/trojan-gfw/trojan/releases/download/v${TROJAN_VERSION}/trojan-${TROJAN_VERSION}-linux-amd64.tar.xz

RUN apk upgrade --update \
    && apk add \
        bash \
        tar \
        tzdata \
        curl \
    && mkdir -p \ 
        ${TROJAN_CONFIG_DIR} \
        /tmp/trojan \
    && curl -L -H "Cache-Control: no-cache" -o /tmp/trojan/trojan.zip ${V2RAY_DOWNLOAD_URL} \
    && pwd \
    && tar -xf /tmp/trojan/trojan.zip -C /tmp/trojan/ \
    && mv /tmp/trojan/trojan /usr/bin \
    && chmod +x /usr/bin/trojan \
    && apk del curl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /tmp/trojan /var/cache/apk/*

ENTRYPOINT ["certbot"]
