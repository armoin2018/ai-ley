# Docker integration for package testing
FROM debian:latest
RUN apt-get update && apt-get install -y dpkg-dev
COPY package.deb /tmp/
RUN dpkg -i /tmp/package.deb || (apt-get install -f -y && dpkg -i /tmp/package.deb)
CMD ["dpkg", "-l"]