# Efficient YUM usage in containers
FROM centos:7

# Install EPEL repository
RUN yum install -y epel-release

# Update system and install packages
RUN yum update -y && \
    yum install -y \
        curl \
        wget \
        git \
        vim \
        htop \
        python3 \
        python3-pip \
    && yum clean all \
    && rm -rf /var/cache/yum

# Install specific package versions
RUN yum install -y nodejs-10.24.1 npm-6.14.11

# Add custom repository
RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce-cli && \
    yum clean all