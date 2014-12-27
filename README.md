docker-jenkins
==============

Dockerfile and stuff around to build and run jenkins in Docker container.

Initially most of the stuff comes from Official Jenkins Docker image "cloudbees/jenkins-ci.org-docker" with major changes like using my own Docker image "ex3cv/debianjessie" available on Docker Hub and another data dir (here /opt/jenkins).
Additionally user jenkins has changed uid - 2000.

Before you'll do anything on the system create user jenkins locally to be able to share a directory in a pretty way between host and container:
```
useradd -d /srv/containers/jenkins/data -u 2000 -m -s /bin/false jenkins
```
Build image and then run container (example command below):
```
docker run --name jenkins_lts -v /srv/containers/jenkins/data:/opt/jenkins -p 127.0.0.1:8080:8080 jenkins_lts/0.1
```
(yes, that's right, jenkins available only on localhost).

If you'd want you can start container during system start. Just copy systemd unit file:
```
copy jenkins-docker.service /etc/systemd/system/
systemctl enable jenkins-docker.service
```
Then you can easily start container:
```
systemctl start jenkins-docker.service
```

Enjoy!

Questions? Ask!
