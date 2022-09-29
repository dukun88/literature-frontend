def credentials = "alfredo"
def server = "masedo@103.181.142.234"
def url = "git@github.com:dukun88/literature-frontend.git"
def branch = "Production"
def dir = "literature-frontend"
def userdock = "alfredo88"
def compfile = "fe.yaml"
def image = "masedo-frontend"
def result = currentBuild.currentResult.toLowerCase()

pipeline {
    agent any
    stages {
        
        stage('Pull frontend Repo') {
            steps {
                sshagent([credentials]) {
                    sh """ssh -o StrictHostkeyChecking=no ${server} <<EOF
                    cd ${dir}
                    git remote add jenkins ${url} || git remote set-url jenkins ${url}
                    git pull ${url} ${branch}
                    exit
                    EOF"""
                }
            }
        }
            
        stage('Build App') {
            steps {
                sshagent([credentials]) {
                    sh """ssh -o StrictHostkeyChecking=no ${server} <<EOF
                    docker compose -f ${compfile} down
                    docker compose -f ${compfile} up -d
                    exit
                    EOF"""
                }
            }
        }
            
       stage('Push to Docker Hub') {
            steps {
                sshagent([credentials]) {
                    sh """ssh -o StrictHostkeyChecking=no ${server} <<EOF
                    docker tag ${image} ${userdock}/${image}:v1
                    docker image push ${userdock}/${image}:v1
                    exit
                    EOF"""
                }
            }
        }
 
        post('Send Notification') {
            always {
            discordSend webhookURL: "https://discord.com/api/webhooks/1021335421482963015/uywS5a2wcsQIeoSXsgjzpCA65aCPLbl1VJU_2hR11rR9cIgp-2PifxR4Gu2ByQG3YBNt",
            title: "${env.JOB_BASE_NAME} #${env.BUILD_NUMBER}",
            result: currentBuild.currentResult,
            description: "**Build:** ${env.BUILD_NUMBER}\n**Status:** ${result}\n\u2060",
            enableArtifactsList: true,
            showChangeset: true
            }
        }
    }
}
