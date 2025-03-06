FROM ubuntu:22.04 AS base

WORKDIR /everest

RUN apt update
RUN apt install -y python3-pip python3-venv git rsync wget cmake doxygen \
  graphviz build-essential clang-tidy cppcheck openjdk-17-jdk npm docker \
  docker-compose libboost-all-dev nodejs libssl-dev libsqlite3-dev \
  clang-format curl rfkill libpcap-dev libevent-dev pkg-config libcap-dev

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN  apt -y --no-install-recommends install tzdata
RUN python3 -m venv ./venv3
ENV PATH="/everest/venv3/bin/:$PATH"
RUN pip install --upgrade pip setuptools wheel jstyleson jsonschema
RUN git clone https://github.com/EVerest/everest-dev-environment.git
RUN pip install everest-dev-environment/dependency_manager
ENV PATH=$PATH:/home/$(whoami)/.local/bin
ENV CPM_SOURCE_CACHE=/everest/.cache/CPM
RUN cd /everest/everest-dev-environment/dependency_manager && (edm init --workspace /everest/everest-workspace)
RUN pip install /everest/everest-workspace/everest-utils/ev-dev-tools
RUN /everest/everest-workspace/Josev/iso15118/shared/pki/create_certs.sh -v iso-2 -i /everest/everest-workspace/everest-core
RUN pip install -r /everest/everest-workspace/Josev/requirements.txt

RUN sed -i 's/"systemctl", {"is-active", "--quiet", "hostapd"}/"pgrep", {"hostapd"}/' /everest/everest-workspace/everest-core/modules/Setup/Setup.cpp
RUN mkdir -p /everest/everest-workspace/everest-core/build
RUN cd /everest/everest-workspace/everest-core/build && cmake ..
RUN cd /everest/everest-workspace/everest-core/build && make -j$(nproc) install

COPY entrypoint.sh /everest/entrypoint.sh
RUN chmod +x /everest/entrypoint.sh

ENTRYPOINT ["/everest/entrypoint.sh"]
