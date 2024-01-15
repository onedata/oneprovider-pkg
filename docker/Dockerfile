ARG BASE_IMAGE
FROM ${BASE_IMAGE}
MAINTAINER Krzysztof Trzepla <krzysztof.trzepla@gmail.com>

# Build arguments
ARG RELEASE
ARG RELEASE_TYPE
ARG DISTRIBUTION=focal
ARG OP_PANEL_VERSION
ARG CLUSTER_MANAGER_VERSION
ARG OP_WORKER_VERSION
ARG ONEPROVIDER_VERSION
ARG ONES3_VERSION
ARG ONEPANEL_AUTOSTART=false
ARG HTTP_PROXY

# Install oneprovider package
RUN case ${RELEASE_TYPE} in \
        production) \
            curl -O http://packages.onedata.org/oneprovider-${RELEASE}.sh; \
            ;; \
        *) \
            curl -O http://packages.devel.onedata.org/oneprovider-${RELEASE}.sh; \
            ;; \
    esac && \
    sh oneprovider-${RELEASE}.sh op-panel=${OP_PANEL_VERSION}-1~${DISTRIBUTION} && \
    sh oneprovider-${RELEASE}.sh cluster-manager=${CLUSTER_MANAGER_VERSION}-1~${DISTRIBUTION} && \
    sh oneprovider-${RELEASE}.sh op-worker=${OP_WORKER_VERSION}-1~${DISTRIBUTION} && \
    sh oneprovider-${RELEASE}.sh oneprovider=${ONEPROVIDER_VERSION}-1~${DISTRIBUTION} && \
    rm -f oneprovider-${RELEASE}.sh

# Install ones3 package
RUN case ${RELEASE_TYPE} in \
        production) \
            curl -O http://packages.onedata.org/oneclient-${RELEASE}.sh; \
            ;; \
        *) \
            curl -O http://packages.devel.onedata.org/oneclient-${RELEASE}.sh; \
            ;; \
    esac && \
    sh oneclient-${RELEASE}.sh ones3=${ONES3_VERSION}-1~${DISTRIBUTION} && \
    rm -f oneclient-${RELEASE}.sh


RUN mkdir -p /volumes/storage
VOLUME ["/volumes/storage"]

RUN pip3 install pyYAML
RUN apt install -y python-is-python2

# Backup files from persistence, as the persistent volume will be overwritten
# by mounting it from host. The missing files will be copied back in entrypoint.
ADD persistence-dir.py /root/persistence-dir.py
RUN python3 /root/persistence-dir.py --backup-persistent-files
# Create symlinks to persistence
RUN python3 /root/persistence-dir.py --create-symlinks

# Add scripts handling service starting and stopping
ADD oneprovider.sh /root/oneprovider.sh
ADD oneprovider.py /root/oneprovider.py
ADD demo /usr/local/bin/demo
ADD await /usr/local/bin/await
ADD setup-demo.sh /root/setup-demo.sh
ADD oneprovider-stop-graceful.sh /root/oneprovider-stop-graceful.sh
ADD internal-scripts/oneprovider-do-stop.sh /root/internal-scripts/oneprovider-do-stop.sh
ADD internal-scripts/oneprovider-ensure-stopped.sh /root/internal-scripts/oneprovider-ensure-stopped.sh
ADD internal-scripts/common.sh /root/internal-scripts/common.sh

# Disable http_proxy for normal operation
ENV http_proxy ""

EXPOSE 80 443 6665 9443

CMD ["/root/oneprovider.sh"]
