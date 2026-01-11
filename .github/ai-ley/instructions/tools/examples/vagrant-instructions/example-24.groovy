// Jenkinsfile - Enterprise Vagrant Pipeline
pipeline {
    agent {
        label 'vagrant-capable'
    }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['development', 'staging', 'production'],
            description: 'Target environment for deployment'
        )
        choice(
            name: 'COMPLIANCE_FRAMEWORK',
            choices: ['SOC2', 'PCI-DSS', 'HIPAA', 'CIS', 'NIST'],
            description: 'Compliance framework to validate against'
        )
        booleanParam(
            name: 'DESTROY_EXISTING',
            defaultValue: false,
            description: 'Destroy existing infrastructure before provisioning'
        )
        booleanParam(
            name: 'SKIP_TESTS',
            defaultValue: false,
            description: 'Skip integration and compliance tests'
        )
    }

    environment {
        VAGRANT_ENV = "${params.ENVIRONMENT}"
        COMPLIANCE_FRAMEWORK = "${params.COMPLIANCE_FRAMEWORK}"
        VAULT_TOKEN = credentials('vault-token')
        AWS_CREDENTIALS = credentials('aws-credentials')
    }

    stages {
        stage('Preparation') {
            steps {
                script {
                    echo "Starting Vagrant deployment for ${params.ENVIRONMENT} environment"
                    sh '''
                        # Verify prerequisites
                        vagrant --version
                        VBoxManage --version || echo "VirtualBox not available"
                        docker --version || echo "Docker not available"
                        ansible --version

                        # Clean workspace
                        rm -rf .vagrant/
                        vagrant global-status --prune
                    '''
                }
            }
        }

        stage('Configuration Validation') {
            parallel {
                stage('Syntax Validation') {
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Validate Vagrantfile syntax
                                ruby -c Vagrantfile
                                echo "Vagrantfile syntax: PASSED"

                                # Validate YAML configurations
                                yamllint config/enterprise.yml
                                echo "YAML validation: PASSED"

                                # Validate Ansible playbooks
                                find provisioning/playbooks -name "*.yml" -exec ansible-playbook --syntax-check {} \\;
                                echo "Ansible syntax validation: PASSED"
                            '''
                        }
                    }
                }

                stage('Security Scanning') {
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Infrastructure as Code security scanning
                                checkov -f Vagrantfile --framework vagrant --output cli

                                # Shell script security analysis
                                find scripts -name "*.sh" -exec shellcheck {} \\;

                                # Ansible security linting
                                ansible-lint provisioning/playbooks/ || true

                                # Secret detection
                                trufflehog --regex --entropy=False .
                            '''
                        }
                    }
                }
            }
        }

        stage('Infrastructure Destroy') {
            when {
                equals expected: true, actual: params.DESTROY_EXISTING
            }
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        echo "Destroying existing infrastructure..."
                        vagrant destroy -f --parallel || true

                        # Clean up any orphaned resources
                        VBoxManage list runningvms | grep -E "vagrant-enterprise" | cut -d'"' -f2 | xargs -I {} VBoxManage controlvm {} poweroff || true
                        VBoxManage list vms | grep -E "vagrant-enterprise" | cut -d'"' -f2 | xargs -I {} VBoxManage unregistervm {} --delete || true
                    '''
                }
            }
        }

        stage('Infrastructure Provisioning') {
            steps {
                script {
                    timeout(time: 45, unit: 'MINUTES') {
                        sh '''
                            cd vagrant-enterprise

                            # Set environment variables
                            export VAGRANT_ENVIRONMENT=${VAGRANT_ENV}
                            export COMPLIANCE_FRAMEWORK=${COMPLIANCE_FRAMEWORK}
                            export ANSIBLE_HOST_KEY_CHECKING=False

                            # Provision infrastructure with detailed logging
                            vagrant up --provision --parallel --debug 2>&1 | tee vagrant-deployment.log

                            # Verify all VMs are running
                            vagrant status | grep "running" | wc -l > vm_count.txt
                            RUNNING_VMS=$(cat vm_count.txt)
                            echo "Running VMs: $RUNNING_VMS"

                            if [ "$RUNNING_VMS" -eq 0 ]; then
                                echo "ERROR: No VMs are running"
                                exit 1
                            fi
                        '''
                    }
                }
            }
        }

        stage('Health Checks') {
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Wait for services to be ready
                        echo "Waiting for services to initialize..."
                        sleep 60

                        # Check VM accessibility
                        vagrant ssh-config > ssh_config

                        # Test SSH connectivity to all VMs
                        for vm in $(vagrant status | grep "running" | awk '{print $1}'); do
                            echo "Testing SSH to $vm..."
                            vagrant ssh $vm -c "uptime" || exit 1
                        done

                        # Check network connectivity
                        vagrant ssh monitoring -c "curl -f http://web01:80" || echo "Warning: Web service not yet ready"
                    '''
                }
            }
        }

        stage('Compliance Validation') {
            when {
                not { equals expected: true, actual: params.SKIP_TESTS }
            }
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Run compliance validation playbook
                        ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \\
                            provisioning/compliance-validation.yml \\
                            --extra-vars "compliance_framework=${COMPLIANCE_FRAMEWORK}" \\
                            --extra-vars "environment=${VAGRANT_ENV}"

                        # Generate compliance report
                        python3 scripts/generate_compliance_report.py \\
                            --environment=${VAGRANT_ENV} \\
                            --framework=${COMPLIANCE_FRAMEWORK} \\
                            --output=reports/compliance-${BUILD_NUMBER}.json
                    '''
                }
            }
        }

        stage('Integration Testing') {
            parallel {
                stage('Service Tests') {
                    when {
                        not { equals expected: true, actual: params.SKIP_TESTS }
                    }
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Service availability tests
                                python3 -m pytest tests/integration/test_services.py \\
                                    --environment=${VAGRANT_ENV} \\
                                    --junitxml=reports/service-tests.xml \\
                                    --verbose
                            '''
                        }
                    }
                }

                stage('Security Tests') {
                    when {
                        not { equals expected: true, actual: params.SKIP_TESTS }
                    }
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Security validation tests
                                python3 -m pytest tests/security/ \\
                                    --environment=${VAGRANT_ENV} \\
                                    --compliance=${COMPLIANCE_FRAMEWORK} \\
                                    --junitxml=reports/security-tests.xml
                            '''
                        }
                    }
                }

                stage('Performance Tests') {
                    when {
                        not { equals expected: true, actual: params.SKIP_TESTS }
                    }
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Performance benchmarks
                                python3 tests/performance/benchmark_suite.py \\
                                    --environment=${VAGRANT_ENV} \\
                                    --output=reports/performance-${BUILD_NUMBER}.json
                            '''
                        }
                    }
                }
            }
        }

        stage('Monitoring Setup') {
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Deploy monitoring stack
                        ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \\
                            provisioning/monitoring-stack.yml

                        # Wait for monitoring services
                        sleep 30

                        # Verify monitoring endpoints
                        vagrant ssh monitoring -c "curl -f http://localhost:9090/api/v1/status/config" || echo "Prometheus not ready"
                        vagrant ssh monitoring -c "curl -f http://localhost:3000/api/health" || echo "Grafana not ready"

                        # Import dashboards
                        python3 scripts/import_dashboards.py --environment=${VAGRANT_ENV}
                    '''
                }
            }
        }

        stage('Documentation Generation') {
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Generate environment documentation
                        python3 scripts/generate_documentation.py \\
                            --environment=${VAGRANT_ENV} \\
                            --compliance=${COMPLIANCE_FRAMEWORK} \\
                            --output=docs/environment-${BUILD_NUMBER}.md

                        # Generate architecture diagrams
                        python3 scripts/generate_diagrams.py \\
                            --environment=${VAGRANT_ENV} \\
                            --output=docs/diagrams/

                        # Create infrastructure inventory
                        vagrant status --machine-readable > reports/infrastructure-inventory.json
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                // Archive artifacts
                archiveArtifacts artifacts: 'vagrant-enterprise/reports/**/*', fingerprint: true
                archiveArtifacts artifacts: 'vagrant-enterprise/docs/**/*', fingerprint: true
                archiveArtifacts artifacts: 'vagrant-enterprise/vagrant-deployment.log', fingerprint: true

                // Publish test results
                publishTestResults testResultsPattern: 'vagrant-enterprise/reports/*-tests.xml'

                // Publish HTML reports
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'vagrant-enterprise/reports',
                    reportFiles: '*.html',
                    reportName: 'Infrastructure Report'
                ])
            }
        }

        success {
            script {
                emailext (
                    subject: "✅ Vagrant Infrastructure Success - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """
                    <h2>Vagrant Infrastructure Deployment Successful</h2>
                    <p><strong>Environment:</strong> ${params.ENVIRONMENT}</p>
                    <p><strong>Compliance Framework:</strong> ${params.COMPLIANCE_FRAMEWORK}</p>
                    <p><strong>Build:</strong> ${env.BUILD_NUMBER}</p>
                    <p><strong>Duration:</strong> ${currentBuild.durationString}</p>

                    <h3>Access URLs:</h3>
                    <ul>
                        <li><a href="http://monitoring.vagrant.local:3000">Grafana Dashboard</a></li>
                        <li><a href="http://monitoring.vagrant.local:9090">Prometheus</a></li>
                        <li><a href="http://monitoring.vagrant.local:5601">Kibana Logs</a></li>
                    </ul>

                    <p>Infrastructure is ready for use.</p>
                    """,
                    mimeType: 'text/html',
                    to: "${env.CHANGE_AUTHOR_EMAIL},devops@enterprise.local"
                )
            }
        }

        failure {
            script {
                // Collect debug information
                sh '''
                    cd vagrant-enterprise || exit 0

                    # Collect VM states
                    vagrant status > debug/vm-status.txt || true
                    vagrant global-status > debug/global-status.txt || true

                    # Collect system logs
                    journalctl -u vagrant-* > debug/systemd-logs.txt || true

                    # Collect Vagrant logs
                    cp .vagrant/logs/* debug/ 2>/dev/null || true
                '''

                emailext (
                    subject: "❌ Vagrant Infrastructure Failed - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """
                    <h2>Vagrant Infrastructure Deployment Failed</h2>
                    <p><strong>Environment:</strong> ${params.ENVIRONMENT}</p>
                    <p><strong>Compliance Framework:</strong> ${params.COMPLIANCE_FRAMEWORK}</p>
                    <p><strong>Build:</strong> ${env.BUILD_NUMBER}</p>
                    <p><strong>Duration:</strong> ${currentBuild.durationString}</p>

                    <p>Please check the console output and debug artifacts for details.</p>
                    <p><a href="${env.BUILD_URL}">View Build</a></p>
                    """,
                    mimeType: 'text/html',
                    to: "${env.CHANGE_AUTHOR_EMAIL},devops@enterprise.local",
                    attachLog: true
                )
            }
        }

        cleanup {
            script {
                if (params.ENVIRONMENT == 'development') {
                    sh '''
                        cd vagrant-enterprise || exit 0
                        # Keep development environments running
                        echo "Development environment preserved"
                    '''
                } else {
                    sh '''
                        cd vagrant-enterprise || exit 0
                        # Clean up non-development environments
                        vagrant destroy -f --parallel || true
                        vagrant global-status --prune || true
                    '''
                }
            }
        }
    }
}