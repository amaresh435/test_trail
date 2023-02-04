pipeline {
    agent any
    tools { 
        maven 'maven-3.8.6' 
    }
    stages {
        stage('Checkout git') {
            steps {
pipeline {
    agent any
    tools { 
        maven 'maven-3.8.6' 
    }
    stages {
        stage('Checkout git') {
            steps {
               git branch: 'main', url: 'https://github.com/amaresh435/test_trail'
            }
        }
        
        stage ('Build & JUnit Test') {
            steps {
                sh 'mvn install' 
            }
            post {
               success {
                    junit 'target/surefire-reports/**/*.xml'
                }   
            }
        }
        stage('SonarQube Analysis'){
            steps{
                   withSonarQubeEnv('sonarqube') {
                        sh 'mvn clean verify sonar:sonar \
                        -Dsonar.projectKey=devsecopsproject-key \
                        -Dsonar.host.url=$sonarurl \
                        -Dsonar.login=$sonarlogin'
                    }
            }
        }
        }
    }
                        
git 'https://github.com/amaresh435/test_trail.git'			  
            }
        }
        
        stage ('Build & JUnit Test') {
            steps {
                sh 'mvn install' 
            }
            post {
               success {
                    junit 'target/surefire-reports/**/*.xml'
                }   
            }
        }
        stage('SonarQube Analysis'){
            steps{
                   withSonarQubeEnv('sonarqube') {
                        sh 'mvn clean verify sonar:sonar \
                          -Dsonar.projectKey=apex_poc_key \
                          -Dsonar.host.url=$sonarurl \
                          -Dsonar.login=$sonar_login'
                    }
            }
        }
    }
} 
