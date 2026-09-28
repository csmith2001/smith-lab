FROM fedora:latest
RUN dnf install -y \
    ansible-core \
    ansible-runner \
    ansible-builder \
    python3 \
    python3-pip \
    openssh-clients \
    git \
    curl \
    wget \
&& dnf clean all

WORKDIR /ansible
CMD ["/bin/bash"]

RUN ansible --version && \
    ansible-playbook --version
