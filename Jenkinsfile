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
                withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_HUB_CREDENTIALS')]) {
                    sh 'docker login -u zah007110 -p $DOCKER_HUB_CREDENTIALS'
                    sh 'docker push zah007110/springboot-hello'
                }
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

