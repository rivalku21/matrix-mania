pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH"
    }
    stages {
        stage("Lint Changed Files on PR to main or MainTest") {
            when {
                expression {
                    return env.CHANGE_TARGET == "main" || env.CHANGE_TARGET == "MainTest"
                }
            }
            steps {
                script {
                    echo "Target Branch: ${env.CHANGE_TARGET}"
                    echo "Linting only changed Swift files..."

                    // Ambil file .swift yang berubah di PR
                    def changedFilesRaw = sh(
                        script: "git diff --name-only origin/${env.CHANGE_TARGET}...HEAD | grep '.swift$' || true",
                        returnStdout: true
                    ).trim()

                    if (changedFilesRaw) {
                        def changedFiles = changedFilesRaw.readLines() // 💡 Lebih aman daripada split("\n")
                        echo "Changed Swift files:\n${changedFiles.join('\n')}"

                        changedFiles.each { file ->
                            echo "Linting: ${file}"
                            sh "swiftlint lint --path '${file}'"
                        }
                    } else {
                        echo "No changed Swift files detected."
                    }
                }
            }
        }
    }
}
