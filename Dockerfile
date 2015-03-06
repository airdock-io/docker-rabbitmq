# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    RabbitMQ Dockerfile
# TO_BUILD:       docker build --rm -t airdock/rabbitmq .
# SOURCE:         https://github.com/airdock-io/docker-rabbitmq

# Pull base image.
FROM airdock/base:latest

MAINTAINER Jerome Guibert <jguibert@gmail.com>

ENV RABBITMQ_VERSION 3.4.4-1

# Install RabbitMQ
# Create  rabbitmq-env.conf and rabbitmq.config
# Log into Docker colector
# TODO -name rabbit@${CONTAINER_SERVER}
RUN curl https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update -qq && \
  apt-get install -y rabbitmq-server=$RABBITMQ_VERSION --no-install-recommends && \
  rabbitmq-plugins enable rabbitmq_management && \
  echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \  
  usermod --home /var/lib/rabbitmq rabbitmq && \  
  echo "NODE_PORT=5672" > /etc/rabbitmq/rabbitmq-env.conf  && \
  echo "USE_LONGNAME=true" >> /etc/rabbitmq/rabbitmq-env.conf  && \
  echo "ulimit -S -n 65536" >> /etc/rabbitmq/rabbitmq-env.conf  && \

  ln -sf /dev/stdout /var/log/rabbitmq/startup_log && \
  ln -sf /dev/stderr /var/log/rabbitmq/startup_err && \
  grep -vE '^\s+-rabbit .*error_logger.*' /usr/lib/rabbitmq/lib/rabbitmq_server-*/sbin/rabbitmq-server > /tmp/rabbitmq-server && \
  chmod +x /tmp/rabbitmq-server && \
  mv /tmp/rabbitmq-server /usr/lib/rabbitmq/lib/rabbitmq_server-*/sbin/rabbitmq-server && \
  /root/post-install

ENV RABBITMQ_SERVER_START_ARGS -eval error_logger:tty(true).

# plugins list
# rabbitmq-plugins enable rabbitmq_mqtt rabbitmq_stomp rabbitmq_management  rabbitmq_management_agent rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management sockjs
#  echo "SERVER_START_ARGS=\"-eval error_logger:tty(true).\""  >> /etc/rabbitmq/rabbitmq-env.conf  && \

# Data Folder
VOLUME ["/var/lib/rabbitmq"]

# AMQP port and Management interface
EXPOSE 5672 15672
# expose epmd port, and the inet_dist_listen_min through inet_dist_listen_max ranges
#EXPOSE 4369 9100 9101 9102 9103 9104 9105

# Define default command.
CMD ["gosu", "rabbitmq:rabbitmq", "rabbitmq-server"]
