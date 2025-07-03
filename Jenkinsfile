pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH" // agar Jenkins bisa temukan brew dan swiftlint
    }
    stages {
        stage('Run SwiftLint') {
            steps {
                echo 'Checking swiftlint location...'
                sh 'which swiftlint'

                echo 'Running SwiftLint...'
                sh 'swiftlint'
            }
        }
    }
}
