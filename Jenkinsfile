pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH"
    }
    stages {
        stage("Lint Changed Swift Files on PR") {
            when {
                expression {
                    return env.CHANGE_ID != null && 
                           (env.CHANGE_TARGET == "main" || env.CHANGE_TARGET == "MainTest")
                }
            }
            steps {
                script {
                    echo "Linting PR to ${env.CHANGE_TARGET}"

                    // Fetch branch target terlebih dahulu
                    sh "git fetch origin ${env.CHANGE_TARGET}:${env.CHANGE_TARGET}"

                    // Gunakan string aman
                    def target = env.CHANGE_TARGET
                    def changedFiles = sh(
                        script: "git diff --name-only origin/${target}...HEAD | grep \\.swift\$ || true",
                        returnStdout: true
                    ).trim()

                    if (changedFiles) {
                        def files = changedFiles.split("\\n")
                        for (file in files) {
                            echo "Linting ${file}"
                            sh "swiftlint lint --path '${file}'"
                        }
                    } else {
                        echo "No Swift files changed."
                    }
                }
            }
        }
    }
}
