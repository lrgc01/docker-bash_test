### Docker+bash test/example

## Environment

- Docker Community Edition
- CentOS 7 from official docker
- HAProxy 1.8 from ius repository
- Nginx from epel repository

## Main files

- centosNginxHA.sh - main script, will use other files
- nginx-entrypoint.sh - a shell script used to start the container
- haproxy.cfg - very basic HAProxy configuration
- index.tmpl - template from default nginx installation - just to 
        record the hostname on each start of the container
- Dockerfile - just as an example. Not used except to match result images.
