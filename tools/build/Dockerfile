FROM ubuntu:16.04
ENV USER odoo
RUN mkdir git
RUN set -x; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ca-certificates
COPY checkout.sh /
COPY addons.txt /
RUN useradd -d / ${USER} && \
    chown -R ${USER}:${USER} /
USER ${USER}
ENTRYPOINT ["/checkout.sh"]