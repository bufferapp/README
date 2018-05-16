# WordPress Blogs

## Theme

### Theme Repository

The theme repository houses the current theme as well as previous themes that Buffer has used over the years. **buffer-2016** is in use across each of the sites right now.

https://github.com/bufferapp/buffer-blog-themes

### buffer-2016

The 2016 theme is a single theme that has various template options available within the WordPress theme options allowing it to be tailored for each individual blog. Including different homepage templates called "newspaper" and "magazine".

buffer-2016 makes use of GULP and SASS to compile & minify scripts and CSS.

### Previous Themes
Previous themes made use of a base theme which was then overwritten by sub themes to customize them for each individual site.

Having one singular code base for each sites theme makes making changes across each of the blogs easier.



## Plugins

Ideally we should explore plugins very carefully before installing them, running audits on installed plugins on a frequent basis to ensure we don't have any installed that aren't in use as well as ensuring upgrades are done to avoid security issues.


## Hosting

We have a number of WordPress blogs at Buffer. These are all hosted on WPEngine, using the same theme across each of the blogs.

Right now WPEngine hosts...
* [Social](http://blog.bufferapp.com/)
* [Open](http://open.buffer.com/)
* [Overflow](https://overflow.buffer.com/)

We have additional sites setup within WPEngine which aren't currently in use. WPEngine allows us to host many installations of WordPress if we wish to expand our blog offering.

### Deployments

WPEngine has its own GIT repository setup which allows you to push to their repositories to deploy to staging or production. Unfortunately this can lead to issues when themes/plugins are changed remotely within WordPress.

Instead we make use of GitHub for hosting the repository and use [DeployBot](http://buffer.deploybot.com/) to manage deployments to each of the blog environments. Right now these are set up to automatically deploy to each of the blog staging sites on merge to master and manual deployments are done to deploy to the production environments.

Previously deployments to production would be done in order of visitor numbers, starting with Overflow, then Open, before finally deploying to Social. DeployBot allows you to quickly rollback a change via their dashboard if required. For bigger changes you can also make use of the WPEngine backup points for extra security.

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


## Local Setup
We have previously made use of MAMP to host WordPress locally. Depending on how familiar you are with Docker, you could also setup a Docker Image with a WordPress environment.

You'll want the buffer-blog-themes repository checked out within the WordPress envirnment so the WordPress installation has access to the themes.

Once setup you can grab an export of the MySQL database from WPEngine via phpMyAdmin to work with real blog content.
