pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run SwiftLint') {
            steps {
                sh 'brew install swiftlint || true'
                sh 'swiftlint'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/swiftlint.log', allowEmptyArchive: true
        }
    }
}
