## Docker+bash test/example

### Environment

- Docker Community Edition
- CentOS 7 from official docker
- HAProxy 1.8 from ius repository
- Nginx from epel repository

### Main files

- centosNginxHA.sh - main script, will use other files
- nginx-entrypoint.sh - a shell script used to start the container
- haproxy.cfg - very basic HAProxy configuration
- index.tmpl - template from default nginx installation - just to 
        record the hostname on each start of the container
- Dockerfile - just as an example. Not used except to match result images.

### Start

Once docker service installed, just run the script centosNginxHA.sh as superuser.
Maybe you want to edit it and change some variables.

### Testing

Just access the docker host using its external IP on port 8000 or 8001, the running
ports of each haproxy in the two docker containers.

http://<my_docker_host_ip>:8000

Use F5 to refresh and watch the Website hostname changing. It's the ugly exadecimal
hostname of each container.
