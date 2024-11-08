pipeline {
    agent any
    environment {
        TELEGRAM_BOT_TOKEN = credentials('telegram-token') // Telegram bot
        TELEGRAM_CHAT_ID = credentials('telegram-chat-id') // Telegram bot chat id
    }
    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t my-web-app .'
            }
        }
        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                sh '''
                docker stop my-web-app || true
                docker rm my-web-app || true
                docker run -d --name my-web-app -p 8090:80 my-web-app
                '''
            }
        }
    }
    post {
        success {
            script {
                sh """
                curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "${TELEGRAM_CHAT_ID}", "text": "✅✅✅Build ${currentBuild.result}\nJob name: ${currentBuild.fullDisplayName}\n Job url: ${env.BUILD_URL}", "disable_notification": false}' https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage
                """
                }
                }
                failure {
                script {
                sh """
                curl -X POST -H 'Content-Type: application/json' -d '{"chat_id": "${TELEGRAM_CHAT_ID}", "text": "❌❌❌Build ${currentBuild.result} \nJob name: ${currentBuild.fullDisplayName}\n \nJob url: ${env.BUILD_URL}", "disable_notification": false}' https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage
                """
            }
        }
    }
}
