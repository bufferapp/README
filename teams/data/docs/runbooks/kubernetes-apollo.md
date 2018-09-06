![2018-03-01_13 43 01_893x656](https://user-images.githubusercontent.com/1682202/36901655-2fb7b434-1e28-11e8-92d4-2920bafefc76.png)

## Background 

On the Data Team we started using Kubernetes more than a year ago and a lot has changed since then! 

Our first uses of Kubernetes were in the `kubetwo` cluster. This cluster was used by the engineering team and since we had some huge workloads we moved away from it to our own cluster. The so called _Data Team Cluster_ started as a test and evolved into the default cluster for new tasks. 

Our workloads were split between `kubetwo` and the _Data Team Cluster_. Both of them in AWS. The main issue with `kubetwo` was that, being a production cluster, one container could degrade the performance. We didn't want to affect end users while we compute stuff like MRR!

After moving to the _Data Team Cluster_ we also realized we needed to do some maintenance. Besides that, it was hard to parse the logs or interact with the cluster easily without having to mess with `kubectl`.

## Enter [Apollo](https://console.cloud.google.com/kubernetes/clusters/details/us-central1-a/apollo?project=buffer-data&authuser=1&organizationId=480078795616&tab=details&persistent_volumes_tablesize=50&storage_class_tablesize=50&nodes_tablesize=50)

This new cluster is the default place to setup deployments, cronjobs or any Kubernetes related task we might want to execute. Apollo is living in Google Cloud and is managed by Google. It comes with a few advantages:

- We can inspect the logs from the Google Cloud Console without needing `kubectl`
- Metrics for the usage of the cluster resources
- Kubernetes auto upgrades
- Visual way of exploring the Kubernetes resources (secrets, cronjobs, …)

This will reduce time we spend configuring or maintaining it! 🔧 

### Why [Apollo](https://console.cloud.google.com/kubernetes/clusters/details/us-central1-a/apollo?project=buffer-data&authuser=1&organizationId=480078795616&tab=details&persistent_volumes_tablesize=50&storage_class_tablesize=50&nodes_tablesize=50)?

Kubernetes or _"κυβερνήτης"_ in Greek means "helmsman of ship" or "governor". This lead to choosing the name *Apollo* for our data team cluster, since Apollo is the greek god of knowledge.
