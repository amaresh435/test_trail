pipeline{
    agent any 
    stages {
        stage('Git Checkout'){
            steps{
                script{   
                    git branch: 'main', url: 'https://github.com/amaresh435/test_trail.git'
                }
            }
        }
        stage('UNIT testing'){
            steps{
                script{  
                    sshagent (credentials: ['deploy-dev']) {
                    sh 'ssh -t -o StrictHostKeyChecking=no ansible@35.223.231.172'
                    sh 'scp /var/lib/jenkins/workspace/* ansible@35.223.231.172:/home/ubuntu'
                  }
                }
            }
        }
        stage('Integration testing'){
            steps{
                script{  
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven build'){
            steps{
                script{  
                    sh 'mvn clean install'
                }
            }
        }
        
        stage('Static code analysis'){
            steps{
                script{  
                    withSonarQubeEnv(credentialsId: 'sonar-api') { 
                        sh 'mvn clean package sonar:sonar'
                    }
                   }
                }
            }
            stage('Quality Gate Status'){   
                steps{
                    script{  
                        waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api'
                    }
                }
            }
        }
}
