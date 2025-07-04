pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH" // agar Jenkins bisa akses swiftlint dan brew
    }
    stages {
        stage('Run SwiftLint') {
            steps {
                echo 'Checking PATH...'
                sh 'echo $PATH'
                
                echo 'Checking swiftlint path...'
                sh 'which swiftlint'
                
                echo 'Running SwiftLint...'
                sh 'swiftlint'
            }
        }
    }
}
