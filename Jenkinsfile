pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = "952969969075"
        AWS_REGION = "us-east-1"
        IMAGE_REPO_NAME = "attendance-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Clone Source') {
            steps {
                git branch: 'main',
                url: 'https://github.com/rasikaitankar/Attendance_Management_System.git'
            }
        }

        stage('Run Tests') {
            steps {
                sh './mvnw test'
            }
        }

        stage('Build Jar') {
            steps {
                sh './mvnw clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t attendance-app:${BUILD_NUMBER} .'
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh '''
                docker tag attendance-app:${BUILD_NUMBER} \
                952969969075.dkr.ecr.us-east-1.amazonaws.com/attendance-app:${BUILD_NUMBER}
                '''
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region us-east-1 | \
                docker login --username AWS --password-stdin \
                952969969075.dkr.ecr.us-east-1.amazonaws.com
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                docker push \
                952969969075.dkr.ecr.us-east-1.amazonaws.com/attendance-app:${BUILD_NUMBER}
                '''
            }
        }
    }

    post {

        success {
            echo 'Build Successful!'
        }

        failure {
            echo 'Build Failed!'
        }
    }
}