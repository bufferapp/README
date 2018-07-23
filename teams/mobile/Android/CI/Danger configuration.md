Danger configuration

Our CI flow currently uses Danger to handle the review of certain PR tasks such as style checks, testing and whether or not critical files have been changed. These checks are in place to allow us to smoothen our review process by eliminating these tasks to be carried out by ourselves (automate everything!). This means we can make better use of code review time by checking the logic of the code itself.

With our configuration for Danger in place, for both projects Bufferbot will leave comments for:

- Abscence of Pull Request descriptions
- WIP Pull requests
- Styling issues (such as line lengths, field naming, incorrect spacing and other formatting errors). This allows us to keep a consistent code style accross files and projects
- Android lint errors and warnings
- Absence of tests for newly created classes
- Absence of changes to tests when you make changes to a file
- Where neccessary there will also be comments left for files that you may have changed where there is sensitive data (such as the ApiUtil or BufferServiceFactory class where you may have changed the API type to DEV).

Whilst these comments are added, they are only there to let you know of these things. It will be your best judgement to know if something should be changed or not :)

# Configuring the Danger process

There are a few main parts to how the flow above operates:

- Dangerfile: There is a Dangerfile at the root of each of the projects. This Dangerfile is repsonsbile for defining the 

- Gradle command: There is a custom gradle command in our root build.gradle file called ```runKtlint```, this essentially runs ktlint and lint checks for each of our modules.

- Bitrise script exxecution: In bitrise we have to run a couple of scripts in-order to get this process working:

<image>

- run Ktlint: We begin by executing the ktlint gradle command in our proejct

- Create ktlint merged report: Next we need to get each of the ktlint reports for each of our modules and merge them into a single report. We also adjust the file paths here so that the github paths are correct for commenting.

- Create Android lint merged report: Then we need to get each of the android lint reports for each of our modules and merge them into a single report. We also adjust the file paths here so that the github paths are correct for commenting.

- Copy reports to depoly path: Next we copy the generated files so that they are accessible by our dangerfile

- Run danger: Finally, run the danger task. This task will then make use of the files mentioned above. In the danger file we also have a custom script which performs diffs on added / modified files to check testing status and notify the PR author of this.