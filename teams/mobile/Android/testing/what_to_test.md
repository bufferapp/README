# What should we be testing?

With the architecture we have in place it makes it super easy for us to create focused and maintainable test classes. What we should test can really vary on what it is we are implementing (e.g should the time be spent writing a complex test for that?) but as a general guide, the following outlines what classes should be tested when creating Pull Requests for our applications.

When it comes to pure Kotlin / Java classes, we should aim to have everything that we can Unit Tested. Unit tests are quick and simple ways to ensure that things are always behaving as expected. UI tests on the other hand can be less reliable and sometimes flakey - whilst we should strive to write UI tests for everything that makes sense to, it's important to not stress that that might not always be the case. 

## Presentation Module

![architecture](https://github.com/bufferapp/README/blob/master/teams/mobile/Android/art/presentation.png?raw=true)

In the Presentation module the core concepts that we implement are Views (such as activities, fragments or custom widgets) and View Model classes. For the activities there should be a User Interface test which at a minimum checks the screen launches. THere will also be tests to ensure that the correct content is displayed and the components function as intended.

For View Model classes, there should be tests to ensure that each of the fucntions in the class returns the expected UI State for that specific operation - this includes both error and success states.

## Data Module

![architecture](https://github.com/bufferapp/README/blob/master/teams/mobile/Android/art/data.png?raw=true)

In the Data module the core concepts that we implement are Use Case classes, Data Repository classes and Data Store Factory classes.

For Use Case classes there should always be a test created to ensure that the stream completes successfully, as well as to check if the expected data is returned where applicable. Data Repository classes handle the orchestration of data to outer layers, so stream completion and correct data flow from the expected data sources should be tested here. For Data Store Factories we simply want to test that the expected data store is returned given the specified conditions.

## Remote Module

![architecture](https://github.com/bufferapp/README/blob/master/teams/mobile/Android/art/remote.png?raw=true)

In the Data module the core concepts that we implement are Data Store classes and Mapper classes.

For Data Store classes we want to ensure that the correct API service calls are made, as well as the created streams handling completion, error and data states as expected. For mapper classes we simply jsut want to be sure that correct data is popualted when mapping to the Data module representation.

## Cache Module

![architecture](https://github.com/bufferapp/README/blob/master/teams/mobile/Android/art/cache.png?raw=true)

In the Data module the core concepts that we implement are Data Store classes, Data Access Object classes and Mapper classes.

For Data Store classes we want to ensure that the correct DAO calls are made, as well as the created streams handling completion, error and data states as expected. For the DAO classes, we need to check that the database operation are behaving as expected - this will include testing any saving, updating and deleting operations that are made. For mapper classes we simply jsut want to be sure that correct data is popualted when mapping to the Data module representation.

## Helper classes

![architecture](https://github.com/bufferapp/README/blob/master/teams/mobile/Android/art/helper.png?raw=true)

Following the general rule from above, helper classes or any other code that can be unit tested should be. These are quick and inexpensive ways of ensuring these classes remain functional as intended over time.
