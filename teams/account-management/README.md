# Account Management

## Setup your local dev environment

To get started on local development and testing:

1. **Get your `buffer-dev` environment setup**
  → https://github.com/bufferapp/buffer-dev

2. **Install the latest version of `yarn`**
  → [Installing Yarn](https://yarnpkg.com/en/docs/install)

3. **Verify your node version**

    Make sure you have node with version <= 9 (Node v10 is not compatible). Using the latest active LTS is advised as our docker containers will run this version: see https://github.com/nodejs/Release.
    ```
    $ node -v
    ```

4. **Install Packages and Bootstrap**
    ```bash
    $ cd ~/buffer-dev  # Or wherever yours is located
    $ docker exec -it bufferdev_login_1 npm install # Will run npm install using the npm version of the Docker container and not your machine

    $ cd ~/buffer-dev/buffer-account  # Or wherever yours is located
    $ yarn
    $ yarn run bootstrap
   ```

5. **Start up the docker containers**
    ```bash
    $ cd ~/buffer-dev # Or wherever yours is located
    $ ./dev up session-service-dev core-authentication-service-dev login-dev account
    # if you want to start the web dashboard locally you add `web` to the above command after `account`
   ```
    **Is the order important?**

   Yes! Login and Account Manager rely on both the **session** and **account** services, so it's important to include them in our *up* command. The order is important, since this relates to the way docker-compose starts up containers.

   **What it `dev` mode?**

   Appending `-dev` to a service name (i.e, `ore-authentication-service-dev`) will run your local code rather than the production docker container.

   **Which services have a dev mode?**

   Only `login`, `core-authentication-service` and `session-service` can be started in dev or production mode. All other services will run the local code by default.

   **When to use dev mode?**

   Whenever you develop one fo these services.

6. **You should now be able to visit https://login.local.buffer.com — party time! 🎉 🙌**

7. **Populate MongoDB with a Buffer admin user**
    ```bash
    $ cd ~/buffer-dev # Or wherever yours is located
    $ ./dev mock admin && ./dev mock generatePublishClient
    ```
8. **You should now be able to login using the following credentials `admin@bufferapp.com / password`**

9. **(Optional) Setup the new Publish dashboard **

    Follow steps from the [Publish Readme](https://github.com/bufferapp/buffer-publish/blob/master/README.md)

## Applications

### Buffer Login

Handles login and logout for Analyze, Publish and Account applications.

Prouduction URL: https://login.buffer.com

Documentation: https://github.com/bufferapp/buffer-login/blob/master/README.md

### Buffer Account

A tool to manage settings and preferences across Buffer's suite of products.

Production URL: https://account.buffer.com

Documentation: https://github.com/bufferapp/buffer-account/blob/master/README.md

### Session Service

A service responsible for managing sessions in redis and verifying that a session is from a valid source. Verification is done with jsonwebtokens (JWT), and only tokens created by this service are considered valid sessions.

Production URL: N\A - internal service

Documentation: https://github.com/bufferapp/session-service/blob/master/README.md

Dashboard: https://app.datadoghq.com/screen/218648/session-service?page=0&is_auto=false&from_ts=1533074820000&to_ts=1533078420000&live=true

Alerts: https://app.datadoghq.com/monitors/manage?q=%22session-service%22

### Core Authentication Service

A service responsible for holding the Buffer account data (email, password, foreign key to user IDs for each product, and product links) in a new MongoDB, and providing features like account creation, authentication, reset password and TFA.

Production URL: N\A - internal service

Documentation: https://github.com/bufferapp/core-authentication-service/blob/master/README.md

## Diagrams and Documentation

- [Architecture Diagrams](architecture.md)
- [Flow charts](flow-charts.md)
