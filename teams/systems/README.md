# Systems 

## How To :memo:

* [Tracing Requests Without Tracing](how-to/do-tracing-without-tracing.md)

## Docker Hub :whale:

We store all of the `bufferapp` docker images in docker hub. To push and pull images we have two different accounts:

### Users

#### bufferbotk8s

This user is used for the `dhbufferapp` secret in Kubernetes and is used to pull images within our Kubernetes clusters.

#### bufferbotcicd

This user is used in both Jenkins and Brigade and is used to push new images to Dockerhub.

### Permissions

#### Owner

Can push and pull images

#### Developer

Can pull any images with the Developer role (used for pulling production images locally for Buffer Dev)
