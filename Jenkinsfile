pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    environment {
        DOCKERHUB = "alitunckasik"
        APP_NAME = "wordpress"
    }

    stages {
        
        stage('Build App Docker Images') {
            steps {
                echo 'Building App Images'
                sh 'docker build --force-rm -t "$DOCKERHUB/$APP_NAME" .'
                sh 'docker image ls'
            }
        }

        stage('Docker Login'){
            steps {
                echo 'Docker Login'
                withCredentials([string(credentialsId: 'DOCKERHUB_TOKEN', variable: 'DOCKERHUB_TOKEN')]) {
                    sh 'docker login -u $DOCKERHUB -p $DOCKERHUB_TOKEN'
                }                 
            }
        }

        stage('Push Images to Docker Hub') {
            steps {
                echo 'Pushing App Images to Docker Hub'
                sh 'docker push "$DOCKERHUB/$APP_NAME"'
            }
        }

        stage('Create Infrastructure for the App') {
            steps {
                sh 'az login --identity'
                echo 'Creating Infrastructure for the App on AZURE Cloud'
                sh 'terraform init'
                sh 'terraform apply --auto-approve'                
            }
        }
        
        stage('Destroy the Infrastructure') {
            steps{
                timeout(time:5, unit:'DAYS'){
                    input message:'Do you want to terminate?'
                }
                sh 'terraform destroy --auto-approve'              
            }
        }
    }
}    
