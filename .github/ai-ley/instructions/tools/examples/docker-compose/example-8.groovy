// Jenkinsfile - Enterprise Docker Compose Pipeline
pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = "enterprise-app"
        DOCKER_BUILDKIT = "1"
        COMPOSE_DOCKER_CLI_BUILD = "1"
        REGISTRY_URL = "your-registry.com"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                script {
                    env.GIT_COMMIT_SHORT = env.GIT_COMMIT.take(7)
                    env.BUILD_TAG = "${env.BRANCH_NAME}-${env.GIT_COMMIT_SHORT}"
                }
            }
        }

        stage('Validate Configuration') {
            steps {
                script {
                    echo "🔍 Validating Docker Compose configuration..."
                    sh 'docker-compose config --quiet'
                    sh 'docker-compose config | jq -e \'.services | length > 0\''
                    echo "✅ Configuration validation completed"
                }
            }
        }

        stage('Security Scan') {
            parallel {
                stage('Dockerfile Lint') {
                    steps {
                        script {
                            sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
                        }
                    }
                }
                stage('Vulnerability Scan') {
                    steps {
                        script {
                            sh '''
                                docker-compose config --services | while read service; do
                                    image=$(docker-compose config | yq eval ".services.$service.image" -)
                                    if [ "$image" != "null" ]; then
                                        echo "Scanning $service: $image"
                                        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
                                            aquasec/trivy:latest image --exit-code 0 --severity HIGH,CRITICAL "$image"
                                    fi
                                done
                            '''
                        }
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "🏗️ Building Docker Compose services..."
                    sh 'docker-compose build --parallel'

                    // Tag images with build information
                    sh '''
                        docker-compose config --services | while read service; do
                            docker tag "${COMPOSE_PROJECT_NAME}_${service}:latest" \
                                "${REGISTRY_URL}/${COMPOSE_PROJECT_NAME}_${service}:${BUILD_TAG}"
                        done
                    '''
                    echo "✅ Build completed"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "🧪 Running tests..."
                    sh 'cp environments/development/.env .env'
                    sh 'docker-compose -f docker-compose.yml -f docker-compose.test.yml up -d'

                    // Wait for services to be ready
                    sh '''
                        timeout 300 bash -c '
                            until docker-compose exec -T web-app curl -f http://localhost:8080/health; do
                                sleep 5
                            done
                        '
                    '''

                    // Run tests
                    sh 'docker-compose exec -T web-app npm run test:unit'
                    sh 'docker-compose exec -T web-app npm run test:integration'

                    echo "✅ Tests completed"
                }
            }
            post {
                always {
                    sh 'docker-compose logs'
                    sh 'docker-compose down -v'
                }
            }
        }

        stage('Push Images') {
            when {
                anyOf {
                    branch 'main'
                    branch 'develop'
                }
            }
            steps {
                script {
                    echo "📦 Pushing images to registry..."
                    withCredentials([usernamePassword(credentialsId: 'docker-registry',
                                                    usernameVariable: 'REGISTRY_USER',
                                                    passwordVariable: 'REGISTRY_PASS')]) {
                        sh 'docker login -u $REGISTRY_USER -p $REGISTRY_PASS $REGISTRY_URL'

                        sh '''
                            docker-compose config --services | while read service; do
                                docker push "${REGISTRY_URL}/${COMPOSE_PROJECT_NAME}_${service}:${BUILD_TAG}"
                            done
                        '''
                    }
                    echo "✅ Images pushed successfully"
                }
            }
        }

        stage('Deploy to Staging') {
            when { branch 'develop' }
            steps {
                script {
                    echo "🚀 Deploying to staging..."
                    sshagent(['staging-ssh-key']) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no deploy@staging-server "
                                cd /opt/enterprise-app
                                git pull origin develop
                                cp environments/staging/.env .env
                                docker-compose -f docker-compose.yml -f environments/staging/docker-compose.override.yml pull
                                docker-compose -f docker-compose.yml -f environments/staging/docker-compose.override.yml up -d
                                docker-compose ps
                            "
                        '''
                    }
                    echo "✅ Staging deployment completed"
                }
            }
        }

        stage('Deploy to Production') {
            when { branch 'main' }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                script {
                    echo "🚀 Deploying to production..."
                    sshagent(['production-ssh-key']) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no deploy@production-server "
                                cd /opt/enterprise-app
                                git pull origin main
                                cp environments/production/.env .env

                                # Blue-green deployment
                                docker-compose -f docker-compose.yml -f environments/production/docker-compose.override.yml pull
                                docker-compose -f docker-compose.yml -f environments/production/docker-compose.override.yml up -d --scale web-app=0

                                # Health check
                                sleep 30
                                curl -f http://localhost:8080/health

                                # Scale up new version
                                docker-compose -f docker-compose.yml -f environments/production/docker-compose.override.yml up -d

                                # Final verification
                                sleep 30
                                curl -f http://localhost:8080/health

                                docker-compose ps
                            "
                        '''
                    }
                    echo "✅ Production deployment completed"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            emailext (
                subject: "❌ Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "The build failed. Please check the console output at ${env.BUILD_URL}",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
        success {
            emailext (
                subject: "✅ Build Successful: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "The build was successful. View details at ${env.BUILD_URL}",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
    }
}