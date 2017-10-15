
## Build
`docker build -t activemq542:0.0.1 .`

## Run
`docker run --rm -p 8161:8161 -p 61616:61616 activemq542:0.0.1`

## Connect to `CONTAINER_NAME` on windows
`winpty docker exec -i -t <CONTAINER_NAME> /bin/bash`
### Start activemq in the container
`/opt/apache-activemq-5.4.2/bin/activemq start`


## Why can't I see the admin page?
Try
'docker inspect <CONTAINER_NAME>'

Then look at the network gateway I.P. address.