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
                steps {
                    sh 'mvn install' 
                }
                post {
                   success {
                        junit 'target/surefire-reports/**/*.xml'
                    }   
                }
                steps{
                script{
                   withSonarQubeEnv(credentialsId: 'sonarqube') {
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
