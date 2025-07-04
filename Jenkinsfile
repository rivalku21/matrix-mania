pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH"
    }
    stages {
        stage("Lint Changed Files on PR to main or develop") {
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
                    def changedFiles = sh(
                        script: "git diff --name-only origin/${env.CHANGE_TARGET}...HEAD | grep '\\.swift$' || true",
                        returnStdout: true
                    ).trim()

                    if (changedFiles) {
                        echo "Changed Swift files:\n${changedFiles}"

                        // Pisahkan menjadi array dan lint satu per satu
                        def files = changedFiles.split("\\n")
                        for (file in files) {
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
