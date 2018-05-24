# `buffer-web` workers in Kubernetes

We are transitionning `buffer-web` utils workers to k8s (Kubernetes). Here what you'll need to know to make changes to this workers

Team members to contact for more information:
* Primary contacts - Eric, Colin

## Contents

* [Architecture](#architecture)
* [Code specific to k8s](#code-specific-to-k8s)
* [Run k8s workers locally](#production-deployments-to-buffer)
* [Production Deployments](#production-deployments-to-buffer)
* [List of workers in k8s](#list-of-workers-in-k8s)
* [Few things to remember](#few-things-to-remember)

## List of workers in k8s
| Worker name | deployment key | Description|
| --- | --- | --- |
| update | worker-update | Use to send updates from our users
| elasticsearch-indexer | worker-elasticsearch-indexer | Index profiles/users/updates in elasticsearch
| followers-backfill | worker-followers-backfill | Backfill follower counts in Mongo
| link | worker-link | increment the buffer button
| patch-records | worker-patch-records | "patch" the image fields for updates with the correct data structure
| signup | worker-signup | Add complimentary information to user after the signup process
| tweet-backfill | worker-tweet-backfill | ?
| twitter-friends | worker-twitter-friends | Index in the twitter friend elasticsearch cluster
| user-cleanup | worker-user-cleanup | clean users information after they leave buffer

All other workers in utils will be migrated soon

## Architecture

To put it in a simple way, we put the `buffer-web` repo in a docker container and run the workers in k8s. [Here the Dockerfile used in production]. The image use the [official PHP 5.6.31](https://github.com/bufferapp/dockerfiles/blob/master/php56-cli/Dockerfile) image, that use itself `Debian 8.9 (jessie)`.

Each workers has its own kubernetes deployment file located in the kube repo, under `kube/us-east1.buffer-k8s.com/workers`. Reach anyone in the system team to have access to it!

Instead of using the "usual" SQS queue, we consume the same queue but with the `k8s_` prefix. So all 

## Code specific to k8s
We set the  [`ENV_KUBERNETES`](https://github.com/bufferapp/buffer-web/blob/37348b9f59c675f420ea7099fd2ed9d0758e4844/Dockerfile.workers#L10
) environnment variable to specify the code that is specific to kubernetes. Here the handy link to see [how it's used](https://github.com/bufferapp/buffer-web/search?utf8=%E2%9C%93&q=ENV_KUBERNETES&type=).

## Run k8s workers locally

Use `buffer-dev` to starts the worker :

- `./dev web-worker start worker_name`
- `./dev web-worker tail worker_name`
- `./dev web-worker stop worker_name`

Note: This way is better than the `./dev worker` command  because it reflects the exact same container as production. 🐳🐳🐳

## Production Deployments 

To deploy to production :

`@bufferbot servicedeploy [deployment-key]`

Note:  You'll probably change some library/models that will affect utils, web or api environnments. In that case, you should aslo deploy to those environnments. Just ask in #eng-deploys if you're unsure :) 
