FROM ex3cv/debian_jessie

MAINTAINER Remigiusz Świc <remigiusz@swic.net.pl>

RUN apt-get -y update && apt-get install -y openjdk-7-jre-headless wget curl git zip && rm -rf /var/lib/apt/lists/*
RUN apt-get -y clean
RUN mkdir /usr/share/jenkins
RUN useradd -d /opt/jenkins -u 2000 -m -s /bin/bash jenkins

COPY init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && cd /tmp && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy && rm -rf /tmp/WEB-INF

ENV JENKINS_HOME /opt/jenkins

# main web interface
EXPOSE 8080
# for attached slave agents (if any)
EXPOSE 50000

# switching to jenkins user
USER jenkins

COPY jenkins.sh /usr/local/bin/jenkins.sh
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

