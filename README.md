# Docker RabbitMQ [![](https://images.microbadger.com/badges/image/airdock/rabbitmq:latest.svg)](https://microbadger.com/images/airdock/rabbitmq:latest "Get your own image badge on microbadger.com")

> This project is no longer actively maintained.
>
> Back in 2017, few open source project provide docker image, etc and our jobs had a real nice goal. Now (2023), all open source community is mature, provides tools and images more than we needs. Thanks to all members for their time and effort.

Docker Image for [RabbitMq](http://www.rabbitmq.com/) based on airdock/base:jessie

What is RabbitMQ?

- Robust messaging for applications
- Easy to use
- Runs on all major operating systems
- Supports a huge number of developer platforms
- Open source and commercially supported

Purpose of this image is:

- install RabbitMQ server
- based on airdock/base:jessie
- enable RabbitMQ Admin Interface and other plugins
- running on rabbitmq user account
- use tini for process managment


> Name: airdock/rabbitmq

***Dependency***: airdock/base:jessie

***Few links***:

- [Docker RabbitMQ](https://registry.hub.docker.com/u/dockerfile/rabbitmq/dockerfile/)
- [Log to Stdout](http://www.superpumpup.com/docker-rabbitmq-stdout)
- [RabbitMQ & Log](https://registry.hub.docker.com/u/dchusovitin/rabbitmq/)
- [RabbitMQ Cluster](https://github.com/cthulhuology/docker-rabbitmq/blob/master/Dockerfile)
- [Java Dzone article](http://java.dzone.com/articles/docker-rabbitmq-cluster)

# Tags

- latest, 3.6.6 -> [3.6.6-1](https://github.com/rabbitmq/rabbitmq-server/releases/tag/rabbitmq_v3_6_6)  [![](https://images.microbadger.com/badges/image/airdock/rabbitmq:latest.svg)](https://microbadger.com/images/airdock/rabbitmq:latest "Get your own image badge on microbadger.com")
- 3.3.5 -> [3.3.5-1.1](http://previous.rabbitmq.com/v3_3_x/documentation.html)  [![](https://images.microbadger.com/badges/image/airdock/rabbitmq:3.3.5.svg)](https://microbadger.com/images/airdock/rabbitmq:3.3.5 "Get your own image badge on microbadger.com")

# Usage

## Launch RabbitMQ server

You should have already install [Docker](https://www.docker.com/).

Execute rabbitmq server with default configuration:
	'docker run -d -p 5672:5672 -p 15672:15672  --name rabbitmq airdock/rabbitmq '


### Run rabbitmq-server with persistent data directory.

	docker run -d  -p 5672:5672 -p 15672:15672  -v /var/lib/rabbitmq:/var/lib/rabbitmq --name rabbitmq airdock/rabbitmq


Take care about your permission on host folder named '/var/lib/rabbitmq'.

The user rabbitmq (uid 4204) in your container should be known into your host.
See :
* [How Managing user in docker container ?](https://github.com/airdock-io/docker-base/wiki/How-Managing-user-in-docker-container)
* [Common User List](https://github.com/airdock-io/docker-base/wiki/Common-User-List)

So you should create an user with this uid:gid:

```
  sudo groupadd rabbitmq -g 4204
  sudo useradd -u 4204  --home-dir /var/lib/rabbitmq --create-home --system --no-user-group rabbitmq
  sudo usermod -g rabbitmq rabbitmq
```
Don't forget to add your current user to this new group.

### Run rabbitmq-server with persistent and log data directory.

```
	docker run -d  -p 5672:5672 -p 15672:15672  -v /var/lib/rabbitmq:/var/lib/rabbitmq -v /var/log/rabbitmq:/var/log/rabbitmq --name rabbitmq airdock/rabbitmq
```


## RabbitMQ Admin Interface

The web UI is located at: http://server-name:15672/
The HTTP API and its documentation are both located at: http://server-name:15672/api/ (or view our latest HTTP API documentation here).
You can download rabbitmqadmin at: http://server-name:15672/cli/

login: guest/guest per default

## Configuration

We have:

- a file /etc/redis/rabbitmq-env.conf overridable with [environment variables](http://www.rabbitmq.com/configure.html).
- a file /etc/redis/rabbitmq.config:
```
[{rabbit, [{loopback_users, []}]}].
```


This configuration use all default configuration from RabbitMQ, except this:

- RabbitMQ to use fully qualified names to identify nodes. USE_LONGNAME true
- set ulimit -S -n 65536 on startup
- some plugins are enabled

### Enabled plugins

- rabbitmq_mqtt
- rabbitmq_stomp
- rabbitmq_management
- rabbitmq_management_agent
- rabbitmq_management_visualiser
- rabbitmq_federation
- rabbitmq_federation_management
- sockjs

### Exposed Port

- AMQP: 5672
- Management interface: 15672
- epmd: 4369
- inet_dist_listen_min through inet_dist_listen_max ranges: 9100, 9101, 9102, 9103, 9104, 9105

# Change Log


## latest and 3.6 (current)

- add RabbitMQ Server 3.6.6-1
- update rabbitmq-server public key
- integrate tini
- launch rabbit with rabbitmq:rabbitmq account
- expose a list of RabbitMQ port 15672 (Admin) and 5672 (RabbitMQ), etc...
- listen all addresses
- data directory "/var/lib/rabbitmq" (from package)
- add volume on log and data folder (/var/lib/rabbitmq and /var/log/rabbitmq)
- MIT license

## 3.3

- integrate tini
- add RabbitMQ Server 3.6.6-1
- launch rabbit with rabbitmq:rabbitmq account
- expose a list of RabbitMQ port 15672 (Admin) and 5672 (RabbitMQ), etc...
- listen all addresses
- data directory "/var/lib/rabbitmq" (from package)
- add volume on log and data folder (/var/lib/rabbitmq and /var/log/rabbitmq)
- MIT license



# Build

- Install "make" utility, and execute: `make build`
- Or execute: 'docker build -t airdock/rabbitmq:latest --rm .'

See [Docker Project Tree](https://github.com/airdock-io/docker-base/wiki/Docker-Project-Tree) for more details.


# MIT License

```
The MIT License (MIT)

Copyright (c) 2015 Airdock.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
