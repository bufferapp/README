# Update Workers Runbook

This is intended to provide resources to refer to in general but also in particular when there is a problem with the update workers.


## What are the update workers?

The update workers are the processes concerned with posting our customers' posts to the social networks.
They run on Kubernetes and there are over 200 of these processes.
They listen to AWS SQS queues and act on the messages therein - each message containing an update id and some additional meta-data.

## DataDog dashboards

* [Twitter](https://app.datadoghq.com/screen/410432/twitter-update-success-rate)
* [Facebook](https://app.datadoghq.com/screen/410427/facebook-update-success-rate)
* [Instagram](https://app.datadoghq.com/screen/410436/instagram-update-success-rate)
* [LinkedIn](https://app.datadoghq.com/screen/410434/linkedin-update-success-rate)
* [Google](https://app.datadoghq.com/screen/410437/google-update-success-rate)
* [Pinterest](https://app.datadoghq.com/screen/410438/pinterest-update-success-rate)

These dashboards split the various aspects of the social networks down across various dimensions.
So, for example, it is possible to see how successful image posts to Facebook groups are.
Or, for another example, to see how successful video posts to Twitter are.
Often, different post types are treated differently by the social networks, so this can be valuable to see if any problem is isolated to some particular network & post type.

Rather than clicking between all these different dashboards, there is also a [generic dashboard](https://app.datadoghq.com/dash/738120/k8s-update-workers-golden-metrics) which can be used to drill down into specific combinations.
This can be used cross-network as well - for example, to investigate if there might be any global image problem when posting from Buffer (as might happen if our S3 connection fails, for example).

## DataDog monitors

There are a number of monitors set up in DataDog around this area.
While generally intended to act as triggers of alerts, they can also be useful to take a look at, to see what 'normal' looks like.

* [Consistent update broadcaster delay problem](https://app.datadoghq.com/monitors/6156700)
* [Updates queue backlog](https://app.datadoghq.com/monitors/835395)
* [Abnormal Error Rates](https://app.datadoghq.com/monitors/3573498)
* [Twitter posting delay](https://app.datadoghq.com/monitors/1757785)
* [Lower percentage of on-time updates](https://app.datadoghq.com/monitors/1879397)
* [Not enough update workers on Kubernetes running](https://app.datadoghq.com/monitors/1000248)
* [Updates look to be delayed!](https://app.datadoghq.com/monitors/6156687)

## In case of problems with the update workers

1. Look to see what networks are affected
2. Look to see what post types are affected

Next steps depend on the answers to these questions.

### If the problem is localised to a single network

(Here, Facebook and Instagram may or may not count as a single network - use your best judgement!)

1. Try posting directly on the service
2. Scan Twitter for any reports of problems (provided Twitter isn't down!)
3. Look at the network's status page for any clues

If you are unable to post direcly, that would suggest a problem at the network's end.
In this situation, there's not too much we can do except to provide information to the customers:

* [Liaise with advocates](https://paper.dropbox.com/doc/Downtime-and-Incident-Protocol-for-Happiness--AOdQUAGFSmajkBNOK~4KB~BwAg-ddIWFnUIcTWunwpxUFSBi) with a view to potentially putting up an in-app banner and updating our status page
* See if you can reproduce the problem and see what error (if any) returns from the network
* If the error is detectable and new, potentially deploy a change in the error handling to give a more intuitive error to customers

If you are able to post directly, that suggests something might have broken at Buffer's end.

1. See if there are any recent deploys that might be relevant
2. If so, look into rolling these back to see if that gives any improvement

If it's still not clear, it's time to roll up the sleeves and investigate!

* [Liaise with advocates](https://paper.dropbox.com/doc/Downtime-and-Incident-Protocol-for-Happiness--AOdQUAGFSmajkBNOK~4KB~BwAg-ddIWFnUIcTWunwpxUFSBi) with a view to potentially putting up an in-app banner and updating our status page
* Make use of a dev server for some live debugging to find out what might be going wrong
* Try and find out if we are making a request to the social network (we should be) and what response it might be returning (if any)
* Report progress and investigation in the #eng-incidents Slack channel

### If the problem is not localised to a single network

In this case, the problem is likely something wrong at Buffer's end, or else some sort of infrastructure / network problem.

1. Check if the Buffer Publish app itself is working at https://buffer.com
2. Check for any recent deploys that may have have an effect - rolling back any that may be the cause
2. Try posting directly on some of the services
3. Scan Twitter for any reports of problems
4. Look at the AWS status page

At this point it may still not be clear what the problem is and it's time to investigate by:

* Making use of a dev server for some live debugging to find out what might be going wrong
* Trying and find out if we are making a request to the social network (we should be) and what response it might be returning (if any)
* Reporting progress and investigation in the #eng-incidents Slack channel

