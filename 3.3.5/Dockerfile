# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    RabbitMQ Dockerfile
# TO_BUILD:       docker build --rm -t airdock/rabbitmq .
# SOURCE:         https://github.com/airdock-io/docker-rabbitmq


FROM airdock/base:jessie

MAINTAINER Jerome Guibert <jguibert@gmail.com>

ENV RABBITMQ_VERSION 3.3.5-1.1

# Install RabbitMQ
# Create  rabbitmq-env.conf and rabbitmq.config
# enable list of plugins
RUN apt-get update -qq && apt-get install -y --no-install-recommends ca-certificates && \
  curl https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update -qq && apt-get install -y rabbitmq-server=$RABBITMQ_VERSION --no-install-recommends && \
  rabbitmq-plugins enable rabbitmq_mqtt rabbitmq_stomp rabbitmq_management  rabbitmq_management_agent rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management sockjs && \
  echo "[{rabbit, [{loopback_users, []}, {tcp_listeners,[{\"0.0.0.0\",5672}]} ]} ]." > /etc/rabbitmq/rabbitmq.config && \
  echo "NODE_PORT=5672" > /etc/rabbitmq/rabbitmq-env.conf  && \
  echo "USE_LONGNAME=true" >> /etc/rabbitmq/rabbitmq-env.conf  && \
  echo "ulimit -S -n 65536" >> /etc/rabbitmq/rabbitmq-env.conf  && \
  apt-get purge -y --auto-remove ca-certificates  && \
  chown rabbitmq:rabbitmq -R /srv/rabbitmq/ && \
  /root/post-install

# Set WORKDIR
WORKDIR /var/lib/rabbitmq

# Set Home
ENV HOME /var/lib/rabbitmq

# Data Folder
VOLUME ["/var/lib/rabbitmq", "/var/log/rabbitmq"]

# AMQP port and Management interface, epmd port, and the inet_dist_listen_min through inet_dist_listen_max ranges
EXPOSE 5672 15672 4369 9100 9101 9102 9103 9104 9105

# Define default command.
CMD ["tini", "-g", "--", "gosu", "rabbitmq:rabbitmq", "/usr/lib/rabbitmq/bin/rabbitmq-server"]
