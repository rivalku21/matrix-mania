pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/bin:$PATH"
    }
    stages {
        stage('Conditional SwiftLint') {
            steps {
                script {
                    def targetBranches = ['main', 'MainTest']
                    def currentBranch = env.BRANCH_NAME

                    echo "Current branch: ${currentBranch}"

                    if (targetBranches.contains(currentBranch)) {
                        echo "Linting for protected branch: ${currentBranch}"

                        // Tentukan base branch untuk diff
                        def diffBase = "origin/${currentBranch}"
                        sh "git fetch origin"

                        def changedFiles = sh(
                            script: "git diff --name-only ${diffBase}...HEAD | grep '\\.swift$' || true",
                            returnStdout: true
                        ).trim()

                        if (changedFiles) {
                            echo "Changed Swift files:\n${changedFiles}"

                            changedFiles.split("\n").each { file ->
                                echo "Linting ${file}"
                                sh "swiftlint lint --path '${file}' || true"
                            }
                        } else {
                            echo "No Swift files changed. Skipping lint."
                        }
                    } else {
                        echo "Branch ${currentBranch} is not in protected list. Skipping SwiftLint."
                    }
                }
            }
        }
    }
}
