pipeline {
    agent any
    stages {
	stage('Checkout') {
        checkout scm
    	}
        stage('Test') {
            steps {
		sh './jenkins/Script.sh'
                
            }
        }
    }
}

