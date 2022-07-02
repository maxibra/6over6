pipelineJob('Fibonacii') {
    displayName('Fibonacii Test and deploy')
    description('Running unitest, build docker and deploy')
    logRotator {
        numToKeep(10)
        artifactNumToKeep(1)
    }
    throttleConcurrentBuilds {
        maxTotal(1)
    }

    definition {
        cps {
            script(readFileFromWorkspace('jenkins_jobs/Jenkinsfile'))
            sandbox()
        }
    }
}
