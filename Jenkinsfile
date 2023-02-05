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


              stage('Quality Gate Statuc Check'){

               agent {
                docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
                }
               }
                  steps{
                      script{
                      withSonarQubeEnv('sonarserver') { 
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



              stage('build')
                {
              steps{
                  script{
		  sh 'cp -r ../devops-training@2/target .'
                  sh 'docker build . -t docker build . -t deekshithsn/devops-training:$Docker_tag'
		  withCredentials([string(credentialsId: 'amarg435', variable: 'docker_hub')]) {			    
				  sh 'docker login -u amarg435 -p $docker_hub'
				  sh 'docker push amarg435/poc_feb2023:$Docker_tag'
			}
                       }
                    }
                 }		
               }     	     
}
