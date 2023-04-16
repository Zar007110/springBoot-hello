pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Zar007110/springBoot-hello.git'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t zah007110/springboot-hello .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run zah007110/springboot-hello ./mvnw test'
            }
        }
        stage('Push') {   
        
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
                }
                sh 'docker push zah007110/springboot-hello:latest'
            }
        }
        stage('Deploy') {
            environment {
                KUBECONFIG = credentials('kubeconfig')
            }
            steps {
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'springboot-hello-deployment.yaml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}

