# https://github.com/phusion/baseimage-docker#using
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
## Update OS
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get -y install openjdk-8-jre-headless wget unzip


## Install Activemq
RUN wget -O "/tmp/apache-activemq-5.4.2-bin.tar.gz" "http://archive.apache.org/dist/activemq/apache-activemq/5.4.2/apache-activemq-5.4.2-bin.tar.gz"
RUN cd /tmp; tar zxvf apache-activemq-5.4.2-bin.tar.gz
RUN mv /tmp/apache-activemq-5.4.2/ /opt
RUN ln -s /opt/apache-activemq-5.4.2 /opt/activemq
RUN chmod 755 /opt/activemq/bin/activemq

## Make start script for activemq
RUN mkdir -p /etc/my_init.d
COPY start_activemq.sh /etc/my_init.d/start_activemq.sh
RUN chmod +x /etc/my_init.d/start_activemq.sh
#### ActiveMQ config
COPY activemq.xml /opt/activemq/conf/activemq.xml
COPY log4j.properties /opt/activemq/conf/log4j.properties
# JMX
COPY jmx.access /opt/activemq/conf/jmx.access
COPY jmx.password /opt/activemq/conf/jmx.password

# New relic
COPY newrelic-java-3.44.1.zip /opt/activemq
RUN cd /opt/activemq; unzip newrelic-java-3.44.1.zip
RUN rm /opt/activemq/newrelic-java-3.44.1.zip
COPY newrelic.yml /opt/activemq/newrelic
RUN mkdir /opt/activemq/logs; chmod ugo+wr /opt/activemq/logs

## Clean up APT when done.
RUN apt-get -y remove wget unzip
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Expose ports
## JMS port
EXPOSE 61616
## Admin web console
EXPOSE 8161
## JMX
EXPOSE 1099