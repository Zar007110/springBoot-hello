pipeline {
    agent any

    tools {
        maven 'maven3'
    }


    stages {
        stage('Build Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Zar007110/springBoot-hello']])
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t zah007110/springboot-hello .'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u zah007110 -p ${dockerhubpwd}'
                    }
                    sh 'docker push zah007110/springboot-hello'
                }
            }
        }


  stage('Deploy to EKS') {
            steps {
                script {
                    // Set the AWS region and EKS cluster name
                    def region = "us-east-1" // Replace with your region
                    def clusterName = "terraformEKScluster" // Replace with your EKS cluster name

                    // Authenticate with the EKS cluster
                    sh "aws eks update-kubeconfig --region ${region} --name ${clusterName}"

                    // Deploy the application to EKS
                    sh "kubectl apply -f kubernetes/deployment.yaml"
                    
                }
            }
        }


    }
}

            
        
    


