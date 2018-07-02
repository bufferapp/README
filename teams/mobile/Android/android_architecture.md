# Android Architecture Guidelines

This document is used to state the architectural pattern that should be followed when either creating new applications or building new features into the application where it makes sense to. This structure allows us to write code that is easy to test and loosely coupled, not being tied tightly to multiple responsibilites. The general structure of our applications should like below:

![architecture](https://github.com/bufferapp/README/tree/master/teams/mobile/Android/art/arch.png?raw=true)

### Presentation

The presentation Module contains everything that is related to the user facing parts of our application. This layer should use MVVM to handle the orchestration of data from the data source to the UI - this will be made up of an Android Architecture Components View Model class implementation which will use the Use Case classes to retrieve data. The View Model class will then create an instance of an immutable UI state class which will then be passed to the View which has subscribed to the data stream. 

This View will then use the model to render it's state. The UI state should be the only state of the View, this way there is only one source of truth for how the display of content is constructed. The UI state should be a sealed class and make use of a Resource State instance (LOADING, SUCCESS, ERROR) so that UI states can easily be composed.

### Data

The Data Module is our access point to external data layers and is used to fetch data from multiple sources (the cache and network), it also contains the Use Case classes (domain logic) which are uses to carry out operations on the data (such as creating an update, closing a conversation). The data layer contains the Data Models which are used in this module and modules higher than it (such as the UI module). The Remote and Cache module models will map to this model, past here the model will never change so it makes no sense to perform any more mappings.

The Use Case classes will use a repository interface which defines the set of operations which can be performed within the data layer. This interface is the implemented by a Data Repository class which will use a Data Store Factory to retrieve an instance of a Data Store Interface to retrieve data from. This Data Store Interface will be implemented by an external layer and allows us to abstract the source of data from our data layer - allowing us to create a more flexible and decoupled data source

### Remote

The Remote module handles all communications with remote sources, in our case it makes simple API calls using a Retrofit interface. This service will be used within a Remote Data store implementation class to retrieve instance of the Remote Model representations - this data store class implements the data store interface from the data layer. The data store class uses a model mapper that will map these Remote models to the model representation found within the Data module.

### Cache

The Cache module handles all communication with the local database which is used to cache data. For this our Database should use the Room architecture component library for the data base, whos data is accessed using DAO classes from said library. 

The cache layer will have it's on Cache Model representations which will be retrieved using the DAOs through the Cache Data Store implementation class, which implements the data store interface from the data layer. This data store class will use a model mapper that will map these Cache models to the model representation found within the Data module.