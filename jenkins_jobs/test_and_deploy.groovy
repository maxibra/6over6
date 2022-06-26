pipelineJob('example') {
    displayName('Job DSL Example Project')
    description('My first job')
    deliveryPipelineConfiguration('qa', 'integration-tests')
    logRotator {
        numToKeep(10)
        artifactNumToKeep(1)
    }
    throttleConcurrentBuilds {
        categmaxTotalories(1)
    }

    definition {
        cps {
            script(readFileFromWorkspace('jenkins_jobs/Jenkinsfile'))
            sandbox()
        }
    }
}