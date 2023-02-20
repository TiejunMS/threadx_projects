# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.209.6/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use hirsuite or bionic on local arm64/Apple Silicon): hirsute, focal, bionic
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# This Dockerfile's base image has a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV VCPKG_ROOT /opt/vcpkg

# Configure CMake repository
# https://apt.kitware.com/
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
    && echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null

# Configure apt and install packages
RUN apt update \
    && export DEBIAN_FRONTEND=noninteractive \
    && rm /usr/share/keyrings/kitware-archive-keyring.gpg \
    #
    # Install C++ tools and Git
    && apt -y install --no-install-recommends sudo build-essential gcc-multilib g++-multilib gdb cgdb cppcheck git cmake kitware-archive-keyring ninja-build zip unzip ethtool iproute2 isc-dhcp-server iptables net-tools dnsutils iputils-ping ncat\
    #
    # [Optional] Update UID/GID if needed
    && if [ "$USER_GID" != "1000" ] || [ "$USER_UID" != "1000" ]; then \
    groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME; \
    fi \
    #
    # Clean up
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install vcpkg dependency manager
RUN git clone https://github.com/Microsoft/vcpkg ${VCPKG_ROOT} \
    && cd ${VCPKG_ROOT} \
    && ./bootstrap-vcpkg.sh \
    && mkdir /root/.vcpkg \
    && touch /root/.vcpkg/vcpkg.path.txt

ENV PATH "${VCPKG_ROOT}:${PATH}"

# Install C++ dependencies using vcpkg
RUN vcpkg integrate install \
    && vcpkg integrate bash
