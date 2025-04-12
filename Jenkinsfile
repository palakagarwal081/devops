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
                withCredentials([usernamePassword(credentialsId: 'azure-credentials-id', usernameVariable: 'AZURE_CLIENT_ID', passwordVariable: 'AZURE_CLIENT_SECRET')]) {
                    bat '''
                        az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant 1a7c998d-d7c1-4821-9e89-e43b6077ecea
                        az acr login --name codecraftacr
                        docker push codecraftacr.azurecr.io/taskapi:latest
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure-credentials-id', usernameVariable: 'AZURE_CLIENT_ID', passwordVariable: 'AZURE_CLIENT_SECRET')]) {
                    script {
                        // Ensure Terraform is initialized
                        sh """
                            terraform init
                            terraform apply -auto-approve
                        """
                    }
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure-credentials-id', usernameVariable: 'AZURE_CLIENT_ID', passwordVariable: 'AZURE_CLIENT_SECRET')]) {
                    bat '''
                        az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant 1a7c998d-d7c1-4821-9e89-e43b6077ecea
                        az aks get-credentials --resource-group codecraft-rg --name codecraft-aks
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }
}
