pipeline {
   agent { label "Hetzner" }
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
           steps{
          sh '''
          CONTAINER=alpine_python_app
          if docker ps --format '{{.Names}}' | grep "$CONTAINER"; then
                echo "App is running"
                docker ps
		  else
				echo "App is not running, starting it"
				echo $WORKSPACE
				docker run -d --name='alpine_python_app' -v $WORKSPACE:/var/volume/ alpine_python_app
				docker ps
			fi
           '''
       }
       }
       stage('Time Check'){
           steps{
        // Check if container is running after 10 seconds"
        sh '''
        sleep 10
        CONTAINER=alpine_python_app
        if docker ps -a --format '{{.Names}}' | grep "$CONTAINER"; then
            echo "Container is running, stoping it"
            docker rm -f alpine_python_app
        else
            echo 'App is stopped'
        fi
		'''
       }
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
