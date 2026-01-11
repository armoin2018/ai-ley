// Jenkinsfile for SVN projects
pipeline {
    agent any
    
    environment {
        SVN_CREDENTIALS = credentials('svn-credentials')
        BUILD_VERSION = "${env.BUILD_NUMBER}"
    }
    
    options {
        skipDefaultCheckout true
    }
    
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout from SVN
                    checkout([
                        $class: 'SubversionSCM',
                        locations: [[
                            credentialsId: 'svn-credentials',
                            depthOption: 'infinity',
                            ignoreExternalsOption: true,
                            local: '.',
                            remote: 'https://svn.example.com/project/trunk'
                        ]],
                        quietOperation: true,
                        workspaceUpdater: [$class: 'UpdateUpdater']
                    ])
                    
                    // Get SVN revision
                    env.SVN_REVISION = sh(
                        script: 'svn info --show-item revision',
                        returnStdout: true
                    ).trim()
                }
            }
        }
        
        stage('Build') {
            steps {
                sh '''
                    echo "Building revision ${SVN_REVISION}"
                    # Add build commands here
                    make clean
                    make all
                '''
            }
        }
        
        stage('Test') {
            steps {
                sh '''
                    # Run tests
                    make test
                    
                    # Generate test reports
                    ./run-tests.sh --output-format=junit
                '''
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }
        
        stage('Deploy') {
            when {
                branch 'trunk'
            }
            steps {
                sh '''
                    # Deploy to staging
                    ./deploy.sh staging
                '''
            }
        }
        
        stage('Tag Release') {
            when {
                allOf {
                    branch 'trunk'
                    expression { return params.CREATE_TAG == true }
                }
            }
            steps {
                script {
                    def tagName = "v${BUILD_VERSION}"
                    sh """
                        svn copy https://svn.example.com/project/trunk \\
                                https://svn.example.com/project/tags/${tagName} \\
                                -m "Release ${tagName} - Build ${BUILD_NUMBER}"
                    """
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'build/**', allowEmptyArchive: true
            cleanWs()
        }
    }
}