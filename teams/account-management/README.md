# Account Management

## Setup your local dev environment

To get started on local development and testing:

1. **Get your `buffer-dev` environment setup**
  → https://github.com/bufferapp/buffer-dev

2. **Install the latest version of `yarn`**
  → [Installing Yarn](https://yarnpkg.com/en/docs/install)

3. **Make sure you have node with version <= 9 (Node v10 is not compatible)**
    ```
    $ node -v
    ```

4. **Install Packages and Bootstrap**
    ```bash
    $ cd ~/buffer-dev/buffer-login  # Or wherever yours is located
    $ yarn
    $ yarn run bootstrap

    $ cd ~/buffer-dev/buffer-account  # Or wherever yours is located
    $ yarn
    $ yarn run bootstrap
   ```

5. **Start up the docker containers**
    ```bash
    $ cd ~/buffer-dev # Or wherever yours is located
    $ ./dev up session-service-dev core-authentication-service-dev login-dev account publish marketing web
   ```

   Login and Account Manager rely on both the **session** and **account** services, so it's important to include them in our _up_ command. The order is important, since this relates to the way docker-compose starts up containers.

   Appending `-dev` to `session-service-dev core-authentication-service-dev login-dev` will tell Docker to use your local container. Removing `-dev` will use the production images, so your local changes will be ignored.

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


### Core Authentication Service

A service responsible for holding the Buffer account data (email, password, foreign key to user IDs for each product, and product links) in a new MongoDB, and providing features like account creation, authentication, reset password and TFA.

Production URL: N\A - internal service

Documentation: https://github.com/bufferapp/core-authentication-service/blob/master/README.md

## Diagrams and Documentation

- [Architecture Diagrams](architecture.md)
- [Flow charts](flow-charts.md)
