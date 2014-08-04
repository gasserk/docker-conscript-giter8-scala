##Setup instructions for Scalatra/Swagger Docker container (from Conscript/Giter8 intermediate image)

###I. Install Docker and build from Dockerfile, or install intermediate Conscript/G8 working image and build up, or  load up a tar

(Please note: for ease of explanation, below I use `HOST>` to denote the Docker host OS shell prompt, or OSX shell on a Mac which is operating via a Type 2 VM like VirtualBox/Boot2Docker; I use `DOCKER>` to denote the shell prompt opened on the Docker Container via `docker run` command)

1. [Install Docker] (http://docs.docker.com/installation/) (NB if you already have VirtualBox running use Customize during  install)

2. Build or Pull or Load the Image
 a. Build Conscript/G8 Docker image from Dockerfile

  i. `HOST> git clone https://github.com/gasserk/docker-conscript-giter8-scala.git`
  
  ii. `HOST> docker build -t MY_IMAGE MY_GIT_CLONE_DIR`
  
  iii. Once the build finishes successfuly, 
    `HOST> docker images` # MY_IMAGE name should appear under 'Repository' where 'none' will appear otherwise

  b. Install Conscript/G8 Docker image via pull from Docker Registry Hub
    `HOST> docker pull gasserk/jdk7-conscript-g8`

  c. Obtain a .tar of the image and use `docker load -i IMAGE.tar` then `docker tag IMAGE_ID MY_IMAGE` (you can get the image id by running `docker images` will show the freshly loaded image with a starting tag of `none`.

###II.  Begin working with giter8-templated projects in Docker

 1. `HOST> docker run -it -p 8080 MY_IMAGE /bin/bash`

 2. `DOCKER>` #follow instructions for creating g8 template projects, e.g. [First Scalatra Project] (http://scalatra.org/2.3/getting-started/first-project.html); [Other G8 templates] (https://github.com/n8han/giter8/wiki/giter8-templates)

 3. `DOCKER> (SBT)>` After starting a Jetty service from SBT prompt (`> container:start`), 
 enter `Ctrl-P, Ctrl-Q` to put process in background

 4. `HOST> docker ps ; env | grep DOCKER_HOST` # combine these to get http://DOCKER_HOST:PORT to access the
 service the Docker container is exposing on 8080. Default: http://192.168.59.103:49153 on OSX and Windows running Boot2Docker.  Note: check `ifconfig` on the Boot2Docker HOST VM if DOCKER_HOST is not available.

 5. `HOST> docker ps -a ; docker attach RUNNING_CONTAINER_ID` # pull the running container id from ps to
 re-access the container's shell

 6. `DOCKER> (SBT)> container:stop` # since you should still be running within SBT, this will stop the Jetty service

 7. `DOCKER> (SBT)> exit`

 8. `DOCKER>` # Git the swagger example repo for scalatra, e.g. and follow along [Scalatra Swagger Guide] (http://scalatra.org/guides/swagger.html), [Scalatra Guide on Git] (https://github.com/scalatra/scalatra-website-examples/tree/master/2.2/swagger-example) 

 9. `DOCKER>` # After compiling project, entering sbt, starting container, enter `Ctrl-P, Ctrl-Q` again

 10. `HOST>` # You should be able to surf to http://DOCKER_HOST:PORT/api_docs to get swagger JSON or 
 /flowers directly for a REST call
 
 11. `HOST>` remember to run `docker commit` on any container you want to save as an image
