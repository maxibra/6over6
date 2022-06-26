DEFAULT_REPO="maxib/jenkins-jasc"
if [ -z "$(echo ${JENKINS_DOCKER_REPO})" ]; then
    JENKINS_DOCKER_REPO=${DEFAULT_REPO}
    echo "JENKINS_DOCKER_REPO is defined to '${DEFAULT_REPO}'"
fi

docker build -t ${JENKINS_DOCKER_REPO} .
