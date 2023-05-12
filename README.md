# deployment-config

This repository provides a deployment model for deploying the DeMAF.

## Prerequisites
Installation of Docker and Docker Compose are required, see https://docs.docker.com/compose/install/

## Deploy Locally
The DeMAF can be deployed on the local machine by executing
```shell
docker-compose pull && docker-compose up -d
```

Shutdown with
```shell
docker-compose down
```

## Using the DeMAF
There are currently two ways for using the DeMAF:
* REST API
* DeMAF-shell

### REST API
The DeMAF provides a REST API for exposing its functionality.

After deploying you can access the OpenAPI definition under http://localhost:8080/swagger-ui/index.html#/

### DeMAF-shell
The DeMAF-shell is a service that provides a CLI for interacting with the DeMAF.

Clone it from https://github.com/UST-DeMAF/demaf-shell and start it as described.


## Transform a Deployment Model
The deployment model uses a volume to exchange data between the DeMAF services running in Docker containers and the local file system. 
It is currently configured to mount the directory under ./volume onto the Docker containers under /usr/share .

### Input
If you want to transform a technology-specific deployment model located on your local file system, either
* copy the files to ./volume , or
* change the path to the local folder that should be mounted in the docker-compose.yml file in line 9.

You can then input the technology-specific deployment model by providing the location URL pointing to /usr/share/{yourDeploymentModel}, which is the path on the Docker container where the deployment model is mounted on.

### Output
The DeMAF outputs the generated technology-agnostic deployment model under ./volume/tadms or the path that you configured.

## Example
* Go to the volume folder
* Clone the Example Deployment Model: ```git clone git@github.com:Well5a/kube.git```
* Go back to the base directory and start the DeMAF: ```docker-compose pull && docker-compose up -d```
* Start the [DeMAF Shell](https://github.com/UST-DeMAF/demaf-shell)
* In the DeMAF Shell, execute the command ```transform --location file:/usr/share/kube/azure-start.sh --technology bash --commands ./azure-start.sh```