FROM alpine:latest

ARG TERRAFORM_VERSION=1.11.4

RUN apk add --no-cache bash curl unzip && \
    curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

CMD ["/bin/sh"]