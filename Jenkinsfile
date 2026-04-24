node {
    stage('Stop Old Containers') {
        sh 'docker compose down || true'
    }

    stage('Build and Deploy') {
        sh 'docker compose up --build -d'
    }
}
