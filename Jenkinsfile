def getDockerTag() {
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true 
    return tag
    }
pipeline{
    agent {
        docker {
            image 'maven'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    environment {
        Docker_tag = getDockerTag()
    }
    
    stages{

        stage('Quality Gate Status Check'){
            steps{
                script{
                    withSonarQubeEnv(installationName: 'sonarqube') {
                        sh 'mvn clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                    }
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate()
                            if (qg.status != 'OK') {
                                error "Pipeline aborted due to quality gate failure: ${qg.status}"
                            }
                    }
                sh "mvn clean install"
                }
            }  
        }	

        stage('build'){
            steps {
                script{
                    sh 'docker build . -t deekshithsn/devops-training:$Docker_tag'
                    withCredentials([string(credentialsId: 'amarg435', variable: 'docker_hub')]) {
                    sh '''docker login -u amarg435 -p $docker_hub
                        docker push amarg435/poc_feb2023:$Docker_tag
                    '''
                    }
                }
            }
        }
    }	       	     	         
}
