node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("mynginx")
    }
    
    stage('Deploy blue container') {
	withAWS(region:'us-east-1', credentials:'ecr_credentials') {
		sh '''
			kubectl apply -f ./blue.yaml
		'''
	}
    }
}
