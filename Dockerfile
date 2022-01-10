FROM alpine:3.12

ENV TERRAFORM_VERSION=0.12.24
ENV KUSTOMIZE_VERSION=v3.4.0
ENV HELM_VERSION=v3.3.0

RUN apk update && \
          apk add --no-cache \
          bash \
          git \
          make \
          jq \
          python3 \
          curl \
          wget \
          openssl \
          gettext \
          gomplate \
          ncurses \
          unzip \
          py-pip && \
          pip install -U awscli && \
          pip3 install -U kubernetes && \
          wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
          chmod +x /usr/local/bin/helm && \
          curl -L https://dl.k8s.io/v1.21.2/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
          chmod +x /usr/local/bin/kubectl && \
          curl -L https://github.com/vmware-tanzu/velero/releases/download/v1.6.1/velero-v1.6.1-linux-amd64.tar.gz --output - | tar -xzO velero-v1.6.1-linux-amd64/velero  > /usr/local/bin/velero && \
          chmod +x /usr/local/bin/velero && \
          curl -L \
          https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
          -o /tmp/terraform.zip && \
          unzip /tmp/terraform.zip -d /usr/local/bin/ && \
          curl -L \
          https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
          -o /tmp/kustomize.tar.gz && \
          tar -xzf /tmp/kustomize.tar.gz -C /tmp && \
          mv /tmp/kustomize /usr/local/bin/kustomize && \
          rm -rf /tmp/* && \
                        rm -rf /var/cache/apk/* && \
                        rm -rf /var/tmp/*
