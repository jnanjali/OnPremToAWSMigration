node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("mynginx:${env.BUILD_ID}")
    }
    stage('push image to dockerhub') {
	    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker_hub_creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
			sh '''
				docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
			'''
		    sh 	"docker tag mynginx:${env.BUILD_ID} anjalicurie/mynginx:${env.BUILD_ID}"
		    sh  "docker push anjalicurie/mynginx:${env.BUILD_ID}"
						
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
			sh  "sed  -i -e \"s/BUILD_TAG/${env.BUILD_ID}/g\" blue.yaml"
			sh "kubectl apply -f blue.yaml"
		}
	}
    }
}
