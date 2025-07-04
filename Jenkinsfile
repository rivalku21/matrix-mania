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
                    def target = env.CHANGE_TARGET
                    echo "Linting PR to ${target}"
                    sh 'echo $PATH'
                    sh 'which swiftlint'
                    sh 'swiftlint version'

                    // Fetch base branch
                    sh "git fetch origin ${target}:${target}"

                    // FIX: Gunakan triple-double quotes
                    def changedFiles = sh(
                        script: """git diff --name-only origin/${target}...HEAD | grep '\\.swift$' || true""",
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
