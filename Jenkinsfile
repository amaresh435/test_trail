pipeline {
  agent any
  tools { 
        maven 'maven-3.8.6' 
    }
    stages{
        stage("sonarqube static code check"){
            agent{
                docker{
                    image 'openjdk:11'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }

            steps{
                script{
                   withSonarQubeEnv(credentialsId: 'sonarcube') {
                       sh 'chmod +x gradlew'
                       sh './gradlew sonarqube'
                    }
                    timeout(5) {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK'){
                            error "pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }

        }
    }

}
