# Kubernetes Deployment Configuration

## Features

* *all* features a locally deployed version of the DeMAF would have (using Docker compose)
* *two* versions: with and without memory and CPU boundaries (requests and limits).
These are based on research for widely used services like our DBs and meassurements taken from a local run using Docker Compose
* *two* PersistantVolumeClaims using the cluster's vSphere default StorageClass
* *RabbitMQ Cluster Kubernetes Operator* (<https://www.rabbitmq.com/kubernetes/operator/operator-overview>)  
  which uses a new `kind` to deploy a full, cluster-wide RabbitMQ resource with a PersistentVolume, StatefulSet, Services for both nodes and management and Pods.

## Issues

Currently, there are two major issues and one minor with this deployment:

1. Our testing cluster is set up in a way where the vSphere storage controller is unable to create cluster-wide, i.e., `ReadWriteMany`, PersistantVolumeClaims.
This can either be resolved using a cluster where such PersistantVolumeClaims are available or by using a network-attached file system (NFS).
Another possible solution could be the usage of an AWS S3 Bucket, Azure Blob Storage or GKE Cloud Storage bucket.
These would be hosted in the cloud and allow access from all nodes in the cluster.
2. The issue with the PersistantVolumeClaims could only be solved in our testing cluster by deploying *all* deployment that use the same PersistantVolumeClaim on the *same* node.
This limits the underlying concept behind Kubernetes - deploying an application on a cluster through the master which distributes the load to multiple nodes.
3. The minor issue is that we were unable to test the bounded deployment config on our testing cluster as other services and deployment were running there.
This made the resources sparce enough for us to be unable to deploy the bounded deployment configuration.
Despite that, running the bounded deployment configuration on a local Minikube works as expected

## Future Work

* Fix both issues
* Once the bounded deployment configuration is deployed, check whether the set requests and limits match the actual requirements of the services
* Look into outsourcing the DBs to Helm charts or using Operators for all.
This could help in improving our deployed DBs as these are mainly provided by the maintainers of the DBs which have a deeper and borader knowledge on how to correctly deploy the DBs.
