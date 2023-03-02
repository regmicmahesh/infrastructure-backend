FROM regmicmahesh/infrastructure-baked-dependencies:latest


RUN curl -LO  https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
