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
    stage('push image to dockerhub') {
	    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker_hub_creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push anjalicurie/mynginx:12
					'''
	    }
    }
    stage('get kubeconfig for eks cluster') {
	script {
		withAWS(region:'us-west-2', credentials:'aws-creds') {
		     sh '''
			 aws eks --region us-west-2 update-kubeconfig --name fabulous-wardrobe-1597385869
		     '''
                }
        }
    }
    stage('Deploy blue container') {
	script {
		withAWS(region:'us-west-2', credentials:'aws-creds') {
			sh '''
				kubectl apply -f ./blue.yaml
			'''
		}
	}
    }
}
