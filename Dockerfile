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
  /root/post-install
  
  
#  echo ""SERVER_START_ARGS -eval error_logger:tty(true)

# Data Folder
VOLUME ["/var/lib/rabbitmq"]

# For RabbitMQ and RabbitMQ Admin
EXPOSE 5672 15672

# Define default command.
CMD ["gosu", "rabbitmq:rabbitmq", "rabbitmq-server"]
