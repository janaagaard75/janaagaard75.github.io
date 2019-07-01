---
layout: post
title: "Part 5: End-to-end Test"
published: true
---

Fifth part of the series about Azure Function in TypeScript where we add an end-to-end test.

In the [previous step](/blog/2019-06-12-part-4-continuous-deployment) we enabled automatic creation of branch environments. Now let’s write a test that verifies the actual endpoint on Azure works. We can break it down into these three steps:

1. Compute the URL our `greet` function app in Azure environment associated with the current branch.
2. Call that endpoint, fetching some data.
3. Verify that we get a 200 OK back and that the returned data is what we expected.

## Local Tests and End-to-end Tests

Our tests are currently being executed before we deploy to Azure, but since we now want to verify the deployed code, we will add a second type of test that will run after deployment. We will call the second type of tests _end-to-end tests_, and for the lack of better name, we will call the other tests _local tests_.

|                | Local Tests                     | End-to-end Test                  |
| -------------- | ------------------------------- | -------------------------------- |
| Speed          | Fast                            | Slow                             |
| Deployment     | Run without deploying           | Must deploy before running       |
| Trustfulness\* | Runs in a simulated environment | Runs on the actual deployed code |

\*) Can we trust that the code works if the test is passing?

Because of the slower execution time and because a failing end-to-end tests won't stop, I recommend that you write most of your tests as local tests, and only have a few end-to-end tests verifying the deployed code. Because of this if chose the keep the short `test` as the file extension and run command, instead of renaming it to something like `test-local`.

## Getting the URL for the Endpoint

`TestHelper.getApiRoolUrl()` gets the root API url through the resource group. It could have been simplified by computing the URL using the current branch name, but the current solution would also work had this not been possible.

1. Compute the name of the resource group based on the name of the current branch.
2. Get a list of all the resources in that group.
3. Find the one that contains the function apps.

```typescript
private static getApiRootUrl(): string {
  const currentBranchName = this.runShellCommand(
    "git symbolic-ref --short HEAD"
  ).trim();
  const resourceGroupName = `azure-functions-typescript-${currentBranchName}`;
  const resourcesInfo = this.runShellCommand(
    `${this.azCommand} resource list --resource-group ${resourceGroupName}`
 );
  const resourceInfos = JSON.parse(resourcesInfo) as Array<ResourceInfo>;
  const functionsResourceName = resourceInfos
    .map(resourceInfo => resourceInfo.name)
    .find(
      resourceName => resourceName.match(/^aft-(.*)-functions$/) !== null
    );

  if (functionsResourceName === undefined) {
    throw new Error(
      `Could not a functions resources in the resource group '${resourceGroupName}'.`
    );
  }

  return `https://${functionsResourceName}.azurewebsites.net/api`;
}
```

{% include previous-next.html
  previousHref="/blog/2019-06-12-part-4-continuous-deployment"
  previousText="Part 4: Continuous Deployment"
  nextHref="/blog/2019-06-12-part-6-refactor"
  nextText="Part 6: Refactor"
%}
