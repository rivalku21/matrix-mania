pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH"
    }
    stages {
        stage("Lint Changed Swift Files on PR") {
            when {
                expression {
                    return env.CHANGE_TARGET == "main" || env.CHANGE_TARGET == "MainTest"
                }
            }
            steps {
                script {
                    echo "Linting PR to ${env.CHANGE_TARGET}"

                    // Debug: pastikan Jenkins pakai swiftlint yang benar
                    sh 'echo $PATH'
                    sh 'which swiftlint'
                    sh 'swiftlint version'

                    // Fetch target branch (e.g., main/MainTest)
                    sh "git fetch origin ${env.CHANGE_TARGET}:${env.CHANGE_TARGET}"

                    // Ambil daftar file .swift yang berubah
                    def changedFiles = sh(
                        script: "git diff --name-only origin/${env.CHANGE_TARGET}...HEAD | grep '\\.swift$' || true",
                        returnStdout: true
                    ).trim()

                    if (changedFiles) {
                        echo "Swift files changed:\n${changedFiles}"
                        def files = changedFiles.split("\\n")
                        for (file in files) {
                            echo "Linting ${file}"
                            sh "swiftlint lint '${file}'"
                        }
                    } else {
                        echo "No Swift files changed."
                    }
                }
            }
        }
    }
}
