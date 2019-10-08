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
RUN useradd -d /git ${USER} && \
    chown -R ${USER}:${USER} /git
USER ${USER}
ENTRYPOINT ["/checkout.sh"]