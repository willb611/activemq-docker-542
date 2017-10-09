# https://github.com/phusion/baseimage-docker#using
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN apt-get -y update && apt-get install -y wget

RUN wget -O "/tmp/apache-activemq-5.4.2-bin.tar.gz" "http://archive.apache.org/dist/activemq/apache-activemq/5.4.2/apache-activemq-5.4.2-bin.tar.gz"
RUN cd /tmp; tar zxvf apache-activemq-5.4.2-bin.tar.gz
RUN cd /tmp/apache-activemq-5.4.2/bin; chmod 755 activemq; mv /tmp/apache-activemq-5.4.2/ /opt
RUN apt-get -y install openjdk-8-jre-headless

# Clean up APT when done.

RUN apt-get -y remove wget

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 61616
EXPOSE 8161