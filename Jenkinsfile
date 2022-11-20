pipeline {
    agent any
    
    environment {
        DOCKER_VERSION_TAG = getVersion()
        AWS_DEFAULT_REGION="eu-central-1"

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
           }
        }
          stage('docker build'){
            steps {
                  sh 'docker image build . -t tsv1982/petclinic:${DOCKER_VERSION_TAG} -t tsv1982/petclinic:latest'
            }
        }
        stage('Docker push with tag'){
            steps {
                 echo "${DOCKER_VERSION_TAG}"
                 withCredentials([string(credentialsId: 'docker_pas', variable: 'dockerHab_pas')]) {
                     sh "docker login -u tsv1982 -p ${dockerHab_pas}"
                 }
                 sh 'docker push tsv1982/petclinic:${DOCKER_VERSION_TAG}'
            }
        }
        stage('Docker push with latest'){
            steps {
                 sh 'docker push tsv1982/petclinic:latest'
            }
        }
         stage('deploy on EC2') {
            steps {
                withCredentials([string(credentialsId: 'Access_key_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'Secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
  //                sh 'aws ec2 run-instances\
  //                   --image-id ami-0d527b8c289b4af7f\
  //                   --subnet-id subnet-0770126826d700875 \
  //                   --instance-type t2.micro\
  //                   --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=petclinic_instance}]"\
  //                   --security-group-ids sg-08e5c6f44bbe5aa6a\
  //                   --associate-public-ip-address \
  //                   --user-data file://script.sh'
                    sh "aws ec2 describe-instances | grep PublicIpAddress | grep -o -P "\d+\.\d+\.\d+\.\d+" | grep -v '^10\.'"
                }
           }
        }
        
    }
   
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
