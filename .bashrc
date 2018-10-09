# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

##############################
# User Functions
##############################
docker-down() {
    docker ps -q | xargs docker stop | xargs docker rm 
}

docker-clear() {
    docker-down
    docker volume ls -qf dangling=true | xargs docker volume rm 
}
