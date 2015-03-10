# Docker RabbitMQ

Docker Image for [RabbitMq](http://www.rabbitmq.com/) based on airdock/base:latest

What is RabbitMQ?

- Robust messaging for applications
- Easy to use
- Runs on all major operating systems
- Supports a huge number of developer platforms
- Open source and commercially supported

Purpose of this image is:

- install RabbitMQ server (3.4.4.1 stable)
- based on airdock/base:latest (debian)
- enable RabbitMQ Admin Interface and other plugins


> Name: airdock/rabbitmq

***Dependency***: airdock/base:latest

***Few links***:

- [Docker RabbitMQ](https://registry.hub.docker.com/u/dockerfile/rabbitmq/dockerfile/)
- [Log to Stdout](http://www.superpumpup.com/docker-rabbitmq-stdout)
- [RabbitMQ & Log](https://registry.hub.docker.com/u/dchusovitin/rabbitmq/)
- [RabbitMQ Cluster](https://github.com/cthulhuology/docker-rabbitmq/blob/master/Dockerfile)
- [Java Dzone article](http://java.dzone.com/articles/docker-rabbitmq-cluster)
 

# Usage

You should have already install [Docker](https://www.docker.com/).
Download [automated build](https://registry.hub.docker.com/u/airdock/) from public [Docker Hub Registry](https://registry.hub.docker.com/):
`docker search airdock`.

Execute rabbitmq server with default configuration:
	'docker run -d -p 5672:5672 -p 15672:15672  --name rabbitmq airdock/rabbitmq '


### Run rabbitmq-server with persistent data directory.

	docker run -d  -p 5672:5672 -p 15672:15672  -v /var/lib/rabbitmq:/var/lib/rabbitmq --name rabbitmq airdock/rabbitmq 
 

Take care about your permission on host folder named '/var/lib/rabbitmq'.

The user redis (uid 4204) in your container should be known into your host.
See [How Managing user in docker container](https://github.com/airdock-io/docker-base/blob/master/README.md#how-managing-user-in-docker-container) and  [Common User List](https://github.com/airdock-io/docker-base/blob/master/CommonUserList.md).

So you should create an user with this uid:gid:

```
  sudo groupadd rabbitmq -g 4204
  sudo useradd -u 4204  --home-dir /var/lib/rabbitmq --create-home --system --no-user-group rabbitmq
  sudo usermod -g rabbitmq rabbitmq
```

### Run rabbitmq-server with persistent and log data directory.


	docker run -d  -p 5672:5672 -p 15672:15672  -v /var/lib/rabbitmq:/var/lib/rabbitmq -v /var/log/rabbitmq:/var/log/rabbitmq --name rabbitmq airdock/rabbitmq 
 


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


## latest (current)

- add RabbitMQ Server
- launch rabbit with rabbitmq:rabbitmq account
- expose a list of RabbitMQ port 15672 (Admin) and 5672 (RabbitMQ), etc...
- listen all addresses
- data directory "/var/lib/rabbitmq" (from package)
- add volume on log and data folder (/var/lib/rabbitmq and /var/log/rabbitmq)


# Build

Alternatively, you can build an image from [Dockerfile](https://github.com/airdock-io/docker-rabbitmq).
Install "make" utility, and execute: `make build`

In Makefile, you could retrieve this *variables*:

- NAME: declare a full image name (aka airdock/rabbitmq)
- VERSION: declare image version

And *tasks*:

- ***all***: alias to 'build'
- ***clean***: remove all container which depends on this image, and remove image previously builded
- ***build***: clean and build the current version
- ***tag_latest***: tag current version with ":latest"
- ***release***: build and execute tag_latest, push image onto registry, and tag git repository
- ***debug***: launch default command with builded image in interactive mode
- ***run***: run image as daemon and print IP address.



# License

```
 Copyright (c) 1998, 1999, 2000 Thai Open Source Software Center Ltd

 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
