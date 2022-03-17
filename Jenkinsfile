pipeline {
    agent any
    
    environment {
        DOCKER_VERSION_TAG = getVersion()

    }

    stages {
        stage('git') {
            steps {
                git branch: 'main', credentialsId: 'git_ssh', url: 'git@github.com:tsv1982/petclinic-docker-jenkins.git'
            }
        }
        stage('build'){
            steps {  
                sh "./mvnw package" 
//                sh "mvn spring-boot:run -Dspring-boot.run.profiles=mysql"
           }
        }
          stage('docker build'){
            steps {
                  sh 'docker image build . -t tsv1982/petclinic:${DOCKER_VERSION_TAG} -t tsv1982/petclinic:latest'
            }
        }
        stage('Docker push'){
            steps {
                 echo "${DOCKER_VERSION_TAG}"
                 withCredentials([string(credentialsId: 'docker_pas', variable: 'dockerHab_pas')]) {
                     sh "docker login -u tsv1982 -p ${dockerHab_pas}"
                 }
                // sh 'docker tag petclinic:latest tsv1982/petclinic:${DOCKER_VERSION_TAG}'
                 sh 'docker push tsv1982/petclinic:${DOCKER_VERSION_TAG}'
                 sh 'docker push tsv1982/petclinic:latest'
                  
            }
        }
        
    }
    
   
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
