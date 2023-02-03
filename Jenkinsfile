node{
       stage('Checkout'){

          checkout scm
       }

       stage('Test'){
         print "Environment will be :date"
         sh 'node -v'
         sh 'npm prune'
         sh 'npm install'
         sh 'npm test'

       }
}
