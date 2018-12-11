# `buffer-web` workers and cron in Kubernetes

We are transitionning `buffer-web` utils workers to k8s (Kubernetes). Here what you'll need to know to make changes to those workers.

Team members to contact for more information:
* Primary contacts - Eric, Colin

## Contents

* [List of workers in k8s](#list-of-workers-in-k8s)
* [List of crons in k8s](#list-of-crons-in-k8s)
* [Deploy workers/crons to k8s](#deploying-workers-or-crons-to-kubernetes)
* [Architecture](#architecture)
* [Code specific to k8s](#code-specific-to-k8s)
* [Run k8s workers locally](#run-k8s-workers-locally)
* [Production Deployments](#production-deployments)

## List of workers in k8s
| Worker name | deployment key | Description|
| --- | --- | --- |
| analytics | worker-analytics | Update analytics
| elasticsearch-indexer | worker-elasticsearch-indexer | Index profiles/users/updates in elasticsearch
| email | worker-email | ???
| gnip analytics | worker-gnip-analytics | Process GNIP analytics for a given twitter profile
| link | worker-link | increment the buffer button
| patch-records | worker-patch-record | "patch" the image fields for updates with the correct data structure
| picture | worker-picture | Process images
| push | worker-push | ???
| quick-analytics | worker-quick-analytics | Update analytics
| s3-cleanup | worker-s3-cleanup | ???
| service | worker-service | ???
| signup | worker-signup | Add complimentary information to user after the signup process
| stripe-webhook | worker-stripe-webhook | ???
| tweet-backfill | worker-tweet-backfill | ?
| twitter-friends | worker-twitter-friends | Index in the twitter friend elasticsearch cluster
| update | worker-update | Use to send updates from our users
| update-migration | worker-update-migration | ???
| user-cleanup | worker-user-cleanup | clean users information after they leave buffer
| weekly-email-digest | worker-eweekly-email-digestmail | Send weekly email stats to our users


## List of crons in k8s
| Cron name | deployment key | Description|
| --- | --- | --- |
| queue-analytics | cron-analytics | Send all due analytics to the analytics queue
| queue-scheduled-updates | cron-updates | Send all due updates to the sqs updates queue (The update workers will process the queue later on)


## Deploying workers or crons to kubernetes

Take the deployment key [of the worker](#list-of-workers-in-k8s) or [crons](#list-of-crons-in-k8s) you want to target, and do:
```
    @bufferbot servicedeploy [deployment key]
```

For example to deploy to the update worker:
```
    @bufferbot servicedeploy worker-update
```

Then you can check the workers has been properly deployed by checking the age of the worker:
```
    kubectl get pods -n workers
```

## Architecture

To put it in a simple way, we put the `buffer-web` repo in a docker container and run the workers in k8s. [Here the Dockerfile used in production](https://github.com/bufferapp/buffer-web/blob/master/Dockerfile.workers). We use the [official PHP 5.6.31](https://github.com/bufferapp/dockerfiles/blob/master/php56-cli/Dockerfile) image, that uses itself `Debian 8.9 (jessie)`.

Each worker has its own kubernetes deployment file located in the kube repo, under `kube/us-east1.buffer-k8s.com/workers`. Reach anyone in the system team to have access to it!

In SQS, the new queue name [has the `_k8s` suffix appened](https://github.com/bufferapp/buffer-web/blob/4eda46cb62a18f9285eab93e33100d7133e92cfc/shared/libraries/Workers/Worker.php#L81-L83) to its previous name. For instance, instead of `update` queue, it will be `update_k8s`

## Code specific to k8s
We set the  [`ENV_KUBERNETES`](https://github.com/bufferapp/buffer-web/blob/37348b9f59c675f420ea7099fd2ed9d0758e4844/Dockerfile.workers#L10
) environnment variable to specify the code that is specific to kubernetes. Here the handy link to see [how it's used](https://github.com/bufferapp/buffer-web/search?utf8=%E2%9C%93&q=ENV_KUBERNETES&type=).

## Run k8s workers locally

Use `buffer-dev` to starts the worker :

- `./dev web-worker start worker_name`
- `./dev web-worker tail worker_name`
- `./dev web-worker stop worker_name`

If you have modified the `Dockerfile.local.worker`, please make sure to `./dev rebuild web-worker` the dev environment.

Note: This way is better than the `./dev worker` command  because it reflects the exact same container as production. 🐳🐳🐳


## Production Deployments 

To deploy to production :

`@bufferbot servicedeploy [deployment-key]`

Note:  You'll probably change some library/models that will affect utils, web or api environnments. In that case, you should aslo deploy to those environnments. Just ask in #eng-deploys if you're unsure :) 
