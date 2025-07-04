pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH"
        BASE_BRANCH = "main"
    }
    stages {
        stage("Lint Changed Swift Files") {
            steps {
                script {
                    sh "git fetch origin ${env.BASE_BRANCH}:${env.BASE_BRANCH}"

                    def changedFilesRaw = sh(
                        script: """git diff --name-only origin/${env.BASE_BRANCH}...HEAD | grep '\\.swift\$' || true""",
                        returnStdout: true
                    ).trim()

                    if (changedFilesRaw) {
                        def files = changedFilesRaw.readLines()
                        echo "Linting changed Swift files:\n${files.join('\n')}"
                        files.each { file ->
                            echo "Linting: ${file}"
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
