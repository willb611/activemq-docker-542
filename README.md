# What is this?
An example dockerfile which has an ActiveMQ server running in it.

## Build
`docker build -t activemq542:0.0.1 .`

## Run
`docker run --rm -p 8161:8161 -p 61616:61616 activemq542:0.0.1`

## Connect to `CONTAINER_NAME` on windows
`winpty docker exec -i -t <CONTAINER_NAME> /bin/bash`

## Admin page
[Should be at http://localhost:8161](http://localhost:8161)

## Why can't I see the admin page?
If you're on windows, sometimes docker network isn't setup properly. Try 'docker inspect <CONTAINER_NAME>'

Then look at the network gateway I.P. address and replace 'localhost' with that IP.