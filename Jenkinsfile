pipeline {
    agent any

    environment {
        ACR_NAME = "codecraftacr.azurecr.io"
        IMAGE_NAME = "taskapi"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/palakagarwal081/devops.git'  // Update this with your GitHub URL
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('ProductService') {
                    script {
                        bat "docker build -t ${ACR_NAME}/${IMAGE_NAME}:latest ."
                    }
                }
            }
        }
        
        stage('Push to ACR') {
            steps {
                script {
                    withCredentials([[$class: 'AzureServicePrincipal', credentialsId: 'azure-credentials-id']]) {
                        // Log into ACR using Azure Service Principal
                        bat 'az acr login --name codecraftacr'
                        bat "docker push ${ACR_NAME}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    withCredentials([[$class: 'AzureServicePrincipal', credentialsId: 'azure-credentials-id']]) {
                        // Log into Azure and get AKS credentials
                        bat 'az aks get-credentials --resource-group codecraft-rg --name codecraft-aks'
                        // Apply Kubernetes deployment and service
                        bat 'kubectl apply -f k8s/deployment.yaml'
                        bat 'kubectl apply -f k8s/service.yaml'
                    }
                }
            }
        }
    }
}
