pipeline {
    agent any
    stages {
	stage('CHECKOUT'){ 
             steps {
                sh 'echo Github CHECKOUT successfully'
		  }
	}
        stage("Run Tests") {
            steps {
                    sh '''
                    echo "Demo testing successfull..."  
                    echo "Checking for Json file with attrinute 'Status' active and replacing with paused value"
		    '''
            }
        }
	stage('Deploy'){
		steps{
			{
		  	def input = input message: 'Write some thing', parameters: [string(defaultValue: '', description: '', name: 'SOMETHING', trim: false)]
		  	echo input
		  	sh "echo ${input}"
			}
                sh 'echo Deploying: Moving to Deploy target folder locatin'  
            }
        }
    }   
