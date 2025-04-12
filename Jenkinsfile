pipeline {
    agent any

    environment {
        ACR_NAME = "codecraftacr.azurecr.io"
        IMAGE_NAME = "taskapi"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourname/yourrepo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    script {
                        docker.build("${ACR_NAME}/${IMAGE_NAME}:latest")
                    }
                }
            }
        }

        stage('Push to ACR') {
            steps {
                script {
                    sh 'az acr login --name codecraftacr'
                    sh "docker push ${ACR_NAME}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    sh 'az aks get-credentials --resource-group codecraft-rg --name codecraft-aks'
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
