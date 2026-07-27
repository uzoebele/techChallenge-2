pipeline {
    agent any

    environment {
        AWS_REGION       = 'us-east-1'
        ECS_CLUSTER      = 'techchallenge2-cluster'

        FRONTEND_REPO    = 'techchallenge2-frontend'
        BACKEND_REPO     = 'techchallenge2-backend'

        FRONTEND_SERVICE = 'techchallenge2-frontend-service'
        BACKEND_SERVICE  = 'techchallenge2-backend-service'

        ALB_URL = 'http://techchallenge2-alb-1870694266.us-east-1.elb.amazonaws.com'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('AWS Authentication') {
            steps {
                script {
                    env.AWS_ACCOUNT_ID = sh(
                        script: 'aws sts get-caller-identity --query Account --output text',
                        returnStdout: true
                    ).trim()

                    env.ECR_REGISTRY =
                        "${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com"
                }
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region "$AWS_REGION" |
                    docker login \
                    --username AWS \
                    --password-stdin "$ECR_REGISTRY"
                '''
            }
        }

        stage('Build Images') {
            steps {
                sh '''
                    docker build \
                    -t "$ECR_REGISTRY/$FRONTEND_REPO:latest" \
                    frontend

                    docker build \
                    -t "$ECR_REGISTRY/$BACKEND_REPO:latest" \
                    backend
                '''
            }
        }

        stage('Push Images') {
            steps {
                sh '''
                    docker push "$ECR_REGISTRY/$FRONTEND_REPO:latest"
                    docker push "$ECR_REGISTRY/$BACKEND_REPO:latest"
                '''
            }
        }

        stage('Deploy to ECS') {
            steps {
                sh '''
                    aws ecs update-service \
                    --cluster "$ECS_CLUSTER" \
                    --service "$BACKEND_SERVICE" \
                    --force-new-deployment > /dev/null

                    aws ecs update-service \
                    --cluster "$ECS_CLUSTER" \
                    --service "$FRONTEND_SERVICE" \
                    --force-new-deployment > /dev/null

                    aws ecs wait services-stable \
                    --cluster "$ECS_CLUSTER" \
                    --services "$BACKEND_SERVICE" "$FRONTEND_SERVICE"
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    curl -fsS "$ALB_URL/" > /dev/null
                    curl -fsS "$ALB_URL/api"
                '''
            }
        }
    }

    post {
        success {
            echo 'Frontend and backend deployed successfully.'
        }

        always {
            sh 'docker image prune -af || true'
        }
    }
}