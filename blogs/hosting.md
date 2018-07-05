## Hosting

We have a number of WordPress blogs at Buffer. These are all currently hosted on WPEngine, using the same theme across each of the blogs.

Right now WPEngine hosts...
* [Social](http://blog.bufferapp.com/)
* [Open](http://open.buffer.com/)
* [Overflow](https://overflow.buffer.com/)

We have additional sites setup within WPEngine which aren't currently in use. WPEngine allows us to host many installations of WordPress if we wish to expand our blog offering.

### Deployments (via DeployBot)

WPEngine has its own GIT repository setup which allows you to push to their repositories to deploy to staging or production. Unfortunately this can lead to issues when themes/plugins are changed remotely within WordPress.

Instead we make use of GitHub for hosting the repository and use [DeployBot](http://buffer.deploybot.com/) to manage deployments to each of the blog environments. 
Right now (June 2018) each of the blogs make use of the same theme which has a single repository on GitHub. Deploybot allows you to add repositories to their system with individual environments configured under a respository. Each environment can deploy select directories under a repository or all of them can be configured to deploy the same content to each environment. 

We have the environments under buffer-blog-themes set up to automatically deploy to each of the blog staging sites when a branch is merged to master and manual deployments are done to deploy to the production environments.

It is advised to deploy to production in order of visitor numbers, starting with Overflow, then Open, before finally deploying to Social. DeployBot allows you to quickly rollback a change via their dashboard if required. For bigger changes you can also make use of the WPEngine backup points for extra security.

In the future we may want to split out blogs to have different environment setups. We can do this by either adding a new repository that is seperate with its own environments or simply add a new environment with the server configured with the new credentials.


### Deployment Slack Shortcuts
Deployments can also be triggered using Slack commands in #eng-deploys. These can be configured within DeployBot.
* /deploy-social-blog-production
* /deploy-social-blog-staging
* /deploy-overflow-blog-production
* /deploy-overflow-blog-staging

### Staging
WPEngine offers a staging environment which can be used to test plugins & themes in the same setup as the production. Within the WPEngine dashboard you can trigger a sync between staging & production to test the latest content within the Staging environment.

* [Social](http://bufferblog.staging.wpengine.com/)
* [Open](https://bufferopen.staging.wpengine.com/)
* [Overflow](https://bufferdevs.staging.wpengine.com/)
