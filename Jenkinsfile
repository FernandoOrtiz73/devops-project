pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        EC2_SSH_CREDENTIALS = credentials('ec2-ssh-credentials-id')
        GITHUB_CREDENTIALS = credentials('github-pat') // Asegúrate de que el ID coincide con el de las credenciales creadas
    }
    stages {
        stage('Checkout') {
            steps {
                git(url: 'https://github.com/FernandoOrtiz73/devops-project.git', credentialsId: 'github-credentials-id')
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
                    sh 'ansible-playbook -i hosts deploy_nginx.yml -o "StrictHostKeyChecking=no"'
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
