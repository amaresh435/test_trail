pipeline {
    agent any
    tools { 
        maven 'maven-3.8.6' 
    }
    stages {


        stage ('Build & JUnit Test') {
            steps {
                sh 'mvn install'
                sh 'echo "Hello-world"'
            }
            post {
               success {
                    junit 'target/surefire-reports/**/*.xml'
                }   
            }
        }
        stage('SonarQube Analysis'){
            steps{
                   withSonarQubeEnv(installationName: 'sonarqube') {
                        sh 'mvn clean org.sonarsource.scanner.maven:sonar-maven-plugin:4.8.0.2856:sonar'
                    }
            }
        }
    }
} 
