pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH"
        BASE_BRANCH = "MainTest" // Ubah ke 'develop' jika ingin dibandingkan ke develop
    }
    stages {
        stage("Lint Changed Swift Files") {
            steps {
                script {
                    echo "Fetching base branch: ${env.BASE_BRANCH}"
                    sh "git fetch origin ${env.BASE_BRANCH}:${env.BASE_BRANCH}"

                    echo "Checking for changed Swift files..."
                    def changedFilesRaw = sh(
                        script: "git diff --name-only ${env.BASE_BRANCH}...HEAD | grep '.swift$' || true",
                        returnStdout: true
                    ).trim()

                    if (changedFilesRaw) {
                        def changedFiles = changedFilesRaw.readLines()
                        echo "Detected Swift files:\n${changedFiles.join('\n')}"

                        changedFiles.each { file ->
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
