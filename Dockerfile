FROM ubuntu:16.04

ENV USER odoo
ENV VERSION 11.0
ENV dev_packages libjpeg-dev \
    libpq-dev \
    libsasl2-dev \
    libldap2-dev \
    libyaml-dev \
    freetds-dev \
    libffi-dev \
    libyaml-dev \
    libtiff5-dev \
    libjpeg8-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    python3-pip

RUN set -x; \
    apt-get update && \
    apt-get install -y --no-install-recommends locales

RUN set -x; \
    locale-gen en_US.UTF-8 && \
    update-locale && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

ENV LANG en_US.UTF-8

COPY requirements.txt /tmp/
RUN set -x; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ca-certificates \
        xz-utils \
        postgresql-client \
        fontconfig \
        libxrender1 \
        libxext6 \
        patch \
        curl \
        bzip2 \
        ssh \
        geoip-database \
        geoip-database-extra \
        libgeoip-dev \
        gcc \
        make \
        file \
        python3-dev \
        python3-lasso \
        node-less \
        node-clean-css \
        python3-coverage \
        ${dev_packages}  && \
    pip3 install setuptools==39.1.0 && \
    curl -o /tmp/requirements-extra.txt -SL https://github.com/odoo/odoo/raw/${VERSION}/requirements.txt && \
    mkdir -p /opt/${USER} && \
    pip3 install urllib3[secure] && \
    pip3 install -r /tmp/requirements.txt && \
    pip3 install -r /tmp/requirements-extra.txt && \
    rm -f /tmp/requirements.txt && \
    rm -f /tmp/requirements-extra.txt && \
    apt-get -y remove ${dev_packages} && \
    apt-get clean all

RUN set -x; \
    curl -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz | \
    tar xJ --strip-components=2 -C /usr/local/bin/ wkhtmltox/bin/wkhtmltopdf

RUN set -x; \
    mkdir -p /opt/${USER}/git && \
    mkdir -p /opt/${USER}/tools &&\
    mkdir -p /opt/${USER}/.local/share/Odoo && \
    useradd -d /opt/${USER} ${USER} && \
    chown -R ${USER}:${USER} /opt/${USER}

COPY entrypoint.sh /opt/${USER}/tools/
COPY odoo.conf /opt/${USER}/tools/
# COPY addons.txt /opt/${USER}/
# COPY checkout.sh /opt/${USER}/
# RUN cd /opt/${USER}/ && \
#     bash checkout.sh
USER ${USER}

VOLUME /opt/${USER}/.local/share/Odoo

WORKDIR /opt/${USER}/

EXPOSE 9999 8069 8071 8072
