# Account Management

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
