
if [ -z "$(echo ${JENKINS_ADMIN_ID})" ]; then 
    echo "Please define JENKINS_ADMIN_ID: export JENKINS_ADMIN_ID=...."
    exit 1
fi

if [ -z "$(echo ${JENKINS_ADMIN_PASSWORD})" ]; then 
    echo "Please define JENKINS_ADMIN_PASSWORD: export JENKINS_ADMIN_PASSWORD=...."
    exit 1
fi


DEFAULT_REPO="maxib/jenkins-jasc"
if [ -z "$(echo ${JENKINS_DOCKER_REPO})" ]; then
    JENKINS_DOCKER_REPO=${DEFAULT_REPO}
    echo "JENKINS_DOCKER_REPO is defined to '${DEFAULT_REPO}'"
fi

echo "Removing the current container ..."
docker rm -f $(docker ps -aq -f "name=jenkins")

echo "Starting the new container ..."
docker run -d \
    --name jenkins \
    -p 8080:8080 \
    --env JENKINS_ADMIN_ID=${JENKINS_ADMIN_ID} \
    --env JENKINS_ADMIN_PASSWORD=${JENKINS_ADMIN_PASSWORD} \
    -v /var/run/docker.sock:/var/run/docker.sock \
    ${JENKINS_DOCKER_REPO}

    # -v jenkins_home:/var/jenkins_home 