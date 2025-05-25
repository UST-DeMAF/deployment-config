# deployment-config

This repository provides a deployment model for deploying the DeMAF.

## Prerequisites

Installation of Docker and Docker Compose are required, see <https://docs.docker.com/compose/install/>

## Deploy Locally

The DeMAF can be deployed on the local machine by executing

```shell
docker-compose pull && docker-compose up -d
```

Shutdown with

```shell
docker-compose down
```

## Deploy on Kubernetes Cluster

The DeMAF has two available Kubernetes deployment configurations (in the `k8s` directory).
One with memory and CPU bounds and one without.

First, take a look at the ConfigMap and configure the DeMAF deployment to your liking.

Then, to deploy use the following command:

```shell
kubectl apply -R -f ./<withBounds|noBounds>
```

To shut down the deployed system you can use this command:

```shell
kubectl delete -R -f ./<withBounds|noBounds>
```

For more details and issues regarding the current deployment, see the [README.md](k8s/README.md) in the `k8s` directory.

## Using the DeMAF

There are currently three ways for using the DeMAF:

- WebUI
- DeMAF-shell
- REST API

### WebUI

Once the DeMAF is deployed (wither using Docker Compose or Kubernetes) you can access it through the WebUI.

The WebUI is available at:

* <http://localhost:80> when deployed locally using Docker Compose.
* <https://try.demaf.de> (or your own domain) when its deployed on a Kubernetes cluster.

### DeMAF-shell

The DeMAF-shell is a service that provides a CLI for interacting with the DeMAF.

Clone it from <https://github.com/UST-DeMAF/demaf-shell> and start it as described.

### REST API

The DeMAF provides a REST API for exposing its functionality.

After deploying you can access the OpenAPI definition under <http://localhost:8080/swagger-ui/index.html#/>

## Transform a Deployment Model

The deployment model uses a volume to exchange data between the DeMAF services running in Docker containers and the local file system.
It is currently configured to mount the directory under `./volume` onto the Docker containers under /usr/share .

### Input

If you want to transform a technology-specific deployment model located on your local file system, either

* copy the files to `./volume` , or
* change the path to the local folder that should be mounted in the docker-compose.yml file in line 9.

You can then input the technology-specific deployment model by providing the location URL pointing to /usr/share/{yourDeploymentModel}, which is the path on the Docker container where the deployment model is mounted on.

### Output

The DeMAF outputs the generated technology-agnostic deployment model under `./volume/tadms` or the path that you configured.

## Example

* Go to the volume folder
* Clone the Example Deployment Model: ```git clone git@github.com:Well5a/kube.git```
* Go back to the base directory and start the DeMAF: ```docker-compose pull && docker-compose up -d```
* Start the [DeMAF Shell](https://github.com/UST-DeMAF/demaf-shell)
* In the DeMAF Shell, execute the command ```transform --location file:/usr/share/kube/azure-start.sh --technology bash --commands ./azure-start.sh```
