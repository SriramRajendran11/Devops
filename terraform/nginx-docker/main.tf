# Set the required provider and versions
terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Configure the docker provider
provider "docker" {
}

# Create a docker image resource
# -> docker pull nginx:latest
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# Create a docker container resource
# -> same as 'docker run --name nginx -p8080:80 -d nginx:latest'
resource "docker_container" "nginx" {
  name    = "nginx"
  image   = docker_image.nginx.image_id

  ports {
    external = 8080
    internal = 80
  }
}

# Or create a service resource
# -> same as 'docker service create -d -p 8081:80 --name nginx-service --replicas 2 nginx:latest'
#resource "docker_service" "nginx_service" {
  #name = "nginx-service"
  #task_spec {
    #container_spec {
      #image = docker_image.nginx.repo_digest
    #}
  #}

  #mode {
    #replicated {
      #replicas = 2
    #}
  #}

  #endpoint_spec {
   #ports {
      #published_port = 8081
      #target_port    = 80
    #}
  #}
#}