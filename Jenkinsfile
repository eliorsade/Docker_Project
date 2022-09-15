pipeline {
   agent any
   stages {
    stage('Clone Sources') {
        steps {
          checkout scm
        } 
      }
      stage('Build Dockerfile') {
    	  steps {  
    	      sh 'docker build -t="alpine_python_app" .' 
    	      sh 'docker ps'
         }
       }
       stage('Docker Run'){
           '''
           for CONTAINER in $(docker ps --format "{{.Names}}")
           do
                if CONTAINER=="alpine_python_app"; then
                    echo "App is not running, starting it"
				    docker run -d --name='alpine_python_app' alpine_python_app
				else
				echo "App is running"
				fi
           done
           '''
       }
       stage('Time Check'){
        // Check if container is running after 10 seconds"
        sh '''
        sleep 10
        CONTAINER=alpine_python_app
        if sudo docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER}\$"; then
            echo "Container is running, stoping it"
            docker rm -f alpine_python_app
        else
            echo 'App is stopped'
        fi
		'''
       }
   }
   post {   
		
		success {   
			sh 'echo "BUILD_NUMBER=$BUILD_NUMBER success"' 
		}   
		failure {
			sh 'echo "BUILD_NUMBER=$BUILD_NUMBER failed"'   
		}   
		unstable {   
			echo 'I will only get executed if this is unstable'   
		}   
   }
}
