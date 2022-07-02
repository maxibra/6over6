# https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code
# https://www.jenkins.io/doc/book/installing/docker/

FROM jenkins/jenkins:2.346.1-lts-jdk11
USER root

# Install Docker from https://get.docker.com/
RUN apt-get update -qq >/dev/null &&\
       DEBIAN_FRONTEND=noninteractive \
              apt-get install -y -qq \
              apt-transport-https \
              ca-certificates \
              curl >/dev/null &&\
       mkdir -p /etc/apt/keyrings && \
              chmod -R 0755 /etc/apt/keyrings &&\
       curl -fsSL "https://download.docker.com/linux/debian/gpg" | \
              gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg &&\
       chmod a+r /etc/apt/keyrings/docker.gpg &&\
       echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian buster stable" > /etc/apt/sources.list.d/docker.list &&\
       apt-get update -qq >/dev/null &&\
       DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
              docker-ce \
              docker-ce-cli \
              containerd.io \
              docker-compose-plugin \
              docker-scan-plugin >/dev/null &&\
       DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
              docker-ce-rootless-extras >/dev/null

# Python
RUN apt update && \
       apt install -y apt-utils software-properties-common
       # add-apt-repository ppa:deadsnakes/ppa && \
       # sudo apt install -y python3.8

USER jenkins

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY casc.yaml /var/jenkins_home/casc.yaml
