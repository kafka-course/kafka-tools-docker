FROM openjdk:17-slim

LABEL maintainer="Marc Gorzala <marc@dancier.net>"

ENV DEBIAN_FRONTEND noninteractive
ENV KAFKA_VERSION="3.1.0"
ENV SCALA_VERSION="2.12"

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y apt-transport-https

RUN ( apt-get update && \
      apt-get install -y --no-install-recommends \
      python3-pip \
      python3-dev \
      wget \
      kafkacat \
      iputils-ping \
      build-essential && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* )

RUN ( pip install pip --upgrade && \
      pip install --upgrade setuptools && \
      pip install kafka-tools )

RUN wget  https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O /tmp/kafka.tgz
RUN ( tar xfz /tmp/kafka.tgz -C /opt && \
      mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
      cd /opt/kafka/bin/ && \
      rm /tmp/kafka.tgz )

ENV PATH="/opt/kafka/bin:${PATH}"