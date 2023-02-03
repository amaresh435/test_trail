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
                    sshagent (['ansible0001']) {
                        sh 'ssh -T StrictHostKeyChecking=no ansible@10.128.15.214'
                        sh 'echo "Hello World01"'
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
