def getDockerTag(){
  def tag = sh script: 'git rev-parse HEAD', returnStdout: true
  return tag
  }
        
pipeline{
  agent any
  environment{
    Docker_tag = getDockerTag()
  }

  stages{
    stage('Sonarqube Quality Gate Status Check'){
      agent {
        docker {
        image 'maven:3.8-openjdk-18-slim'
        args '-v $HOME/.m2:/root/.m2'
        }
      }
        steps{
          script{
            withSonarQubeEnv(credentialsId: 'sonar_token_GCP_VM') {
              sh "mvn sonar:sonar"
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
    stage('Maven Package Jar Creation'){
      agent {
                docker {
                image 'maven:3.8-openjdk-18-slim'
                args '-v $HOME/.m2:/root/.m2'
                }
      }
        steps{
          script{
            withSonarQubeEnv(credentialsId: 'sonar_token_GCP_VM') {
              sh "mvn clean install"
          }
        }
      }        
    }
    stage('Building Docker Image'){
      steps{
        sh '''
          whoami
          echo $WORKSPACE
          docker build . -t amarg435/poc_feb2023:$Docker_tag
        '''
      }
    }
    stage('Image Scanning Trivy'){
      agent {
        docker { 
          image 'aquasec/trivy' 
        }
      }
      steps{
        sh ''' 
          mkdir -p trivy-image-scan/
          #trivy image amarg435/poc_feb2023:$Docker_tag > trivy-image-scan/trivy-image-scan-$BUILD_NUMBER.txt
          #ls -lart trivy-image-scan/trivy-image-scan-$BUILD_NUMBER.txt
          #cat trivy-image-scan/trivy-image-scan-$BUILD_NUMBER.txt
        '''
      }
    }
    stage('Pushing Docker Image into Docker Hub'){
      steps{
        withCredentials([string(credentialsId: 'amarg435', variable: 'docker_hub')]) {
        sh '''
          docker login -u amarg435 -p $docker_hub
          docker push amarg435/poc_feb2023:$Docker_tag
        '''
         }
      }
    }
    stage('Removing Docker Image'){
      steps{
        sh '''
          docker rmi amarg435/poc_feb2023:$Docker_tag
        '''
      }
    }
   stage('Deploying application on k8s cluster') {
      steps {
         script{
           withCredentials([kubeconfigFile(credentialsId: '	KUBECONFIG', variable: 'KUBECONFIG')]) {
            dir('kubernetes/') {
              sh ' step here ' 
            }
          }
         }
      }
    }

    stage('verifying app deployment'){
      steps{
        script{
           withCredentials([kubeconfigFile(credentialsId: 'KUBECONFIG', variable: 'KUBECONFIG')]) {
             sh 'sh ' step here ' '

           }
        }
      }
    }
  }
}
