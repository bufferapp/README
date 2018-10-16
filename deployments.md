# Deploying Code at Buffer 🚀

Team members to contact for more information:

* Primary contacts - Adnan, Colin, Dan, Eric, Steven
* Secondary - Anyone else should also be able to help

## Contents

* [Introduction](#introduction)
* [Production Deployments](#production-deployments-to-buffer)
* [Staging Deployments](#staging-deployments-of-buffer)

## Introduction

At Buffer, we use several methods to help deploy code as flexibly as possible. Given the number of environment types we deploy in, there are a fair number of possible commands depending on your use case.

Most deployments currently run through Slack and are triggered via a Slackbot command. Newer services being developed are running through a CI/CD process that deploys to production whenever commits are added to the `master` branch of their corresponding repository.

## Production Deployments

The command to generate a new deployment to production is:

`@bufferbot deploy <environment>`

This command should be run in the `#eng-deploys` room in Slack. It triggers a build which deploys the latest commit in the `master` branch to a selected environment.

Buffer's current main codebase is structured as a monolith. Therefore it can be deployed to several environments. The environments available currently are as followed:

* `web`
* `api`
* ~~`utils`~~ (DEPRECATED: All workers are in Kubernetes now, [see here](https://github.com/bufferapp/README/blob/master/buffer-web-workers-kubernetes.md#deploying-workers-or-crons-to-kubernetes).)
* ~~`utils-updates`~~ (DEPRECATED: The `update` workers are in Kubernetes now, [see here](https://github.com/bufferapp/README/blob/master/buffer-web-workers-kubernetes.md#deploying-workers-or-crons-to-kubernetes).)
* `cron` ( for `cron updates` and  `cron analytics`, [see here](https://github.com/bufferapp/README/blob/master/buffer-web-workers-kubernetes.md#deploying-workers-or-crons-to-kubernetes))



The command currently accepts only a single environment at a time.

Example: `@bufferbot deploy web`

Prior to deployment, do a quick check with the team using `@here ok for deploy to <environment>?` message. This is in case anyone has done a deployment and is still monitoring for any regressions or in case someone is about to do a deployment of their own and needs to get it out asap. In the future we'll be able to automate this away. If you get some `+1` emoji reactions or no replies after about 5 minutes at most, feel free to deploy.

```
TODO: The process of deploying to multiple production environments
```

## Staging Deployments

Part of our development flow allows for staging servers. If you wish to test your work on the staging servers then the below flow is for you.

**For testing changes to the API**

`@bufferbot deploy <branch> to dev-api`

Example: `@bufferbot deploy task/my-important-task to dev-api`

This command accepts `master` as a branch too.

**For testing changes to the frontend/product itself**

`@bufferbot devdeploy <branch>`

To test changes that you would normally deploy to the `web` environment, we have a different approach. Buffer has 3 staging servers set up. The command `devdeploy` helps manage sharing these servers with each other.

Example: `@bufferbot devdeploy task/my-special-task`

The above example will deploy the branch to one of our 3 staging servers and will reply with a message stating which server was used and which dev url you can find your deployment at. The machine it is deployed to is then locked to your name. The next time you do a `devdeploy` it will automatically redeploy to the same machine. If anyone else wishes to use that machine, they must explicity unlock it. Machines are automatically unlocked every 12 hours unless an explicit desire to have it locked for longer has been expressed.

There are other commands possible with `devdeploy`.

**Get the statuses of each dev machine:** `@bufferbot devdeploy status`

**Unlock a machine you need or if you are done with it** `@bufferbot devdeploy unlock <dev1/dev2/dev3>`

The above command shows the choice of machines. If you wish to unlock `dev3` you'd use `@bufferbot devdeploy unlock dev3`

**Create a provisional lock on your machine** `@bufferbot devdeploy lock <dev1/dev2/dev3>`

In some cases, you might want to keep your dev environment around for longer than 12 hours. In that case you'd run this command. It gives you the choice of selecting of locking the machine for 24/36/48 hours. The choice is made directly through the slack interface.

**Deploying to a dev machine of your choice** `@bufferbot devdeploy <branch> to <dev1/dev2/dev3>`

NOTE: This is a USE ONLY IF YOU ABSOLUTELY MUST command. The logic behind this warning is that if you have a use case that depends on staging a deployment to particular machine, this is considered a code smell in many cases. That said, it's hart to avoid it 100% of the time. Therefore this command has been offered as an escape hatch.

```
TODO: Add screenshots
```

```
TODO: Micro service deployments
```

## Rollbacks

In the case of an emergency, how do you rollback?

### Using helm

Assuming you have helm (v2.8.2) [Mac os / Linux binary], run `helm history buffer-publish-master`

You'll see something like this:

![helm history](http://hi.buffer.com/7af033b2c5e2/Image%202018-09-12%20at%201.10.33%20AM.png)


2. Eyeball the time of deployment and identify which REVISION corresponds to the git commit you want to rollback to. Assume in this case it's 165 (at the time of sending this mail, y'all are up to 168)

3. Run `helm rollback buffer-publish-master 165`.

4. Run `helm history buffer-publish-master` to verify it worked. (You should see a new REVISION. In this case it would have been 169 and instead of saying Upgrade complete, it would say Rollback to 165)


### Using kuberdash (beta)

For buffer-publish:

1. Go to <secret>`hAQICAHiNkzgvn++REwHHO+eri0S+Wdk1uZD6ZjADroinALmauwGApBCi8WwL88pZI66DsKtYAAAAdjB0BgkqhkiG9w0BBwagZzBlAgEAMGAGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMiXEhZb/TCaDtrrxBAgEQgDPG+H25cn2Sachj70SlJlWVQmK6PoZcUzKYsFqe5IPru3KWdSIxco3xMThTKFJ4YDdS5Bw=`</secret>
   * Refer [the encryption tool docs](encryption-tool.md) to decrypt the above string.

2. Click `view rollout history` for a deployment. In the next screen, enter buffer for namespace and buffer-publish-master for deployment:
![enter buffer namespace](https://dha4w82d62smt.cloudfront.net/items/2L2a1i0b1y1p403t2O2d/Image%202018-09-12%20at%201.17.23%20AM.png)

3. Click `view rollbacks`. Wait. Wait. Wait for it. And you should see something like this:
![View Rollbacks](http://hi.buffer.com/040ac0b05cc1/viewrollouthistory.png)


4.Using the timestamps (**times are in UTC**) as a hint, browse to the ID you wish to use. Let's use ID 16 as an example here.
![view rollout revision](http://hi.buffer.com/29e38670a29c/viewrevision.png)


5. Check if the tag (the part after bufferapp/buffer-publish) matches the git hash you wish to rollback to. If it does, click revert to this revision. You'll get redirected to the version list page.
ID 16 should have vanished and ID 20 should now be available.

If you don't see ID 20, then that means the rollback failed (sorry for poor error messaging or the lack of any error messaging).

There's an occasional bug which causes the redirect after completing the request to timeout immediately. You'll just see a white page. Hit **f5** and you should see the list of releases again.

Here's a gallery of pictures for anyone interested in a test rollback scenario using a test branch on kuberdash

* [1](http://hi.buffer.com/64a9b5878f60/Image%202018-09-12%20at%201.17.23%20AM.png)
* [2](http://hi.buffer.com/040ac0b05cc1/viewrollouthistory.png) (note the ID's available)
* [3](http://hi.buffer.com/29e38670a29c/viewrevision.png)
* [4](http://hi.buffer.com/da927fb0fdd4/finallistofrevisions.png) (note that ID 2 has vanished and has been replaced with ID 5)

This experience isn't great no matter which way you do it. Both involve gut checks at some level rather than being confident that the system is guiding you to do the right thing. Adnan is hoping to bump up the priority on fixing the experience around this during Teddy cycle. But for the moment, here's hoping this information is helpful but isn't even needed in the near future :).
