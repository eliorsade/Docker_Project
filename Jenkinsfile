CONTAINER=`docker ps -q`	
if [ -z "$CONTAINER" ]; then
    echo "No running containers. Nothing to stop"
else									
    docker stop ${CONTAINER}
    docker rm ${CONTAINER}
fi
