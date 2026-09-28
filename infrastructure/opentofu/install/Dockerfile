FROM fedora:latest
RUN dnf install -y \
    git \
    tree \
    jq \
    yq \
    openssh-clients \
    curl \
    vim \
&& dnf clean all

COPY /install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh

WORKDIR /tofu
CMD ["/bin/bash"]

RUN tofu version
