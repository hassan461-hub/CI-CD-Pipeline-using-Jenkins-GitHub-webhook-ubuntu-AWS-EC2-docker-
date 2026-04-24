node {
    stage('Stop Old Containers') {
        sh 'sudo docker-compose down || true'
    }

    stage('Build and Deploy') {
        sh 'sudo docker-compose up --build -d'
    }

    stage('Check Containers') {
        sh 'sudo docker ps'
    }
}
