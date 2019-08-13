FROM ubuntu:16.04
LABEL maintainer="Odoo S.A. <info@odoo.com>"

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8
MAINTAINER <support@savoirfairelinux.com> Savoir-faire Linux Inc.

ENV USER odoo
ENV VERSION 11.0
# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
ENV USER odoodev
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
    pip3 install zc.buildout==2.12.1 && \
    curl -o /tmp/requirements.txt -SL https://github.com/odoo/odoo/raw/${VERSION}/requirements.txt && \
    mkdir -p /opt/${USER} && \
    python3 /tmp/frozen2requirements.py /tmp/frozen.cfg > /tmp/requirements-extra.txt && \
    pip3 install urllib3[secure] && \
    pip3 install -r /tmp/requirements-extra.txt && \
    pip3 install -r /tmp/requirements.txt && \
    rm -f /tmp/requirements.txt && \
    rm -f /tmp/requirements-extra.txt && \
    rm -f /tmp/frozen2requirements.py && \
    apt-get -y remove ${dev_packages} && \
    apt-get clean all


COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/
RUN chown odoo /etc/odoo/odoo.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
        && chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services
EXPOSE 8069 8071 9999

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]