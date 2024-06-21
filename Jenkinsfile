pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        EC2_SSH_CREDENTIALS = credentials('ec2-ssh-credentials-id')
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-github-username/devops-prc.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('mecamorfogalvanico238/devitaly')
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials-id') {
                        docker.image('mecamorfogalvanico238/devitaly').push('latest')
                    }
                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                sshagent(['ec2-ssh-credentials-id']) {
                    sh 'ansible-playbook deploy_nginx.yml'
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}
