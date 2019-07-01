---
layout: post
title: "Part 4: Continuous Deployment"
published: true
---

Fourth part in the series about Azure Functions in TypeScript. In this part the continuous integration pipeline is extended into a _continuous deployment_ pipeline, where code pushed to GitHub is it automatically deployed to Azure. Until now the code has only been running locally, and this is somewhat ironic since we are halfway into a series about cloud computing. We will remedy this now.

The [code after this fourth part](https://github.com/janaagaard75/azure-functions-typescript/tree/part4).

While we could log in to the Azure Portal, create the necessary resources, and upload the code manually, we will deploy the hard way, by scripting everything so that get _infrastructure as code_ where everything is checked into our source tree.

[Azure's Asset Resource Management templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/) are tricky at first, but once you have used a development setup with automated deployment, I guarantee that you will not want to go back to manual deployments. If you want to know more about all the benefits, the great Martin Fowler has a [series about continuous integration](https://martinfowler.com/articles/continuousIntegration.html) where he explains all the benefits.

You need an account on Azure. You can create one for free on [portal.azure.com](https://portal.azure.com/). If you're new to Azure I recommend that you try some of the manual tutorial out there to get a feel for how the portal works.

## Branch Environments

Each branch in our source code has an associated unique environment on Azure. New environments are automatically spawned when new branches are created. With such a setup there is are no specific development, test or staging environments. Instead, each branch environment takes each of these role corresponding to the state of the task. So while you're developing the task it's a dev environment, when the tests run it's a test environment, and when the task is tested manually it's a staging environment.

The production environment is simply the one associated with the master branch. Well, almost. In real world applications, the production environment probably has more resources and nicer URLs than the branch environments, and that leads to also having a test environment that mimics the production setup. But in this tutorial we have the luxury of keeping all environments identical, thus simplifying the infrastructure code and fully respecting [dev/prod parity](https://12factor.net/dev-prod-parity).

Example:

- Brach name: `master`.
- Azure resource group name: `azure-functions-typescript-master`.
- Endpoint address for the Greet function: `https://aft-master-functions.azurewebsites.net/api/greet/`.

{% include figure.html
  src="/images/function-app-resources.png"
  alt="Azure resources as shown on the Azure Portal"
  caption="Azure resources as shown on the Azure Portal."
%}

## Continuous Deployment Pipeline

1. The step `Create or update Azure resources` in [`config.yml`](https://github.com/janaagaard75/azure-functions-typescript/blob/part4/.circleci/config.yml) calls `create-azure-resources.sh` with the branch name as a parameter.
2. [`create-azure-resources.sh`](https://github.com/janaagaard75/azure-functions-typescript/blob/part4/.circleci/create-azure-resources.sh) uses the [Azure Command-Line Interface](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest) (the `az` command) to create a resource group and then the resources inside the group. The resources are described in [`azure-resources.json`](https://github.com/janaagaard75/azure-functions-typescript/blob/part4/.circleci/azure-resources.json).
3. The step `Publish code to Azure` in [`config.yml`](https://github.com/janaagaard75/azure-functions-typescript/blob/part4/.circleci/config.yml) calls `publish-to-azure.sh` with the branch name as a parameter.
4. [`publish-to-azure.sh`](https://github.com/janaagaard75/azure-functions-typescript/blob/part4/.circleci/publish-to-azure.sh) uses the Azure CLI to copy the compiled JavaScript to Azure.

## Naming Azure Resources

As you can tell just from the length of the official [Naming conventions for Azure resources](https://docs.microsoft.com/en-us/azure/architecture/best-practices/naming-conventions), naming resources in Azure is surprising difficult.

Here are the main restrictions:

- Resource names have to be globally unique. Yes, that's across all users of Azure, not just your own/your company's!
- There are different restrictions depending on the type of the resource.
- Some resources have very restrictive naming rules. Storage accounts names are probably the worst. They can only be 24 characters long and cannot contain any punctuation.

### Hash in Resource Name

We can use `uniqueString()` to generates a unique string, making sure that we don't have a name clash with someone else, and at 13 characters it's short enough to fit into the storage account name.

`"[concat('aft', uniqueString(resourceGroup().id), 'sa')]"`
<br>becomes `aftjmjv7xd3kilis-appsa`.

### Branch name in Resource Name

The function apps resource uses the branch name as part of the resource:

`[concat('aft-', skip(resourceGroup().name, length('azure-functions-typescript-')), '-functions')]`
<br>becomes `aft-master-functions`.

Using the branch name as part of the function app name puts some restrictions on the branch names:

- Only lower cased US letters and hyphens.
- Maximum length of 47 characters.\*
- Don't start or end with a hyphen, and don't use consecutive hyphens.

\*) Max_function_app_length - (length(`atf-`) + length(`-function`))
<br>= 60 - (4 + 9)
<br>= 47.

A test should verify 1) that a branch name adhere to these rules, and 2) that it doesn't clash with the name of another branch before the resources are published. This has not been done.

## Installing Azure CLI in CircleCI and Giving CircleCI Access to Azure

It's quite complicated to install the Azure CLI on CircleCI, but fortunately the [Azure CLI orb](https://circleci.com/orbs/registry/orb/circleci/azure-cli) handles that. The orb uses the two parameters `AZURE_PASSWORD` and `AZURE_USERNAME` when signing in to Azure, so add them as environment variables in CircleCI.

{% include figure.html
  src="/images/circleci-environment-variables.png"
  alt="Environment variables defined in CircleCI"
  caption="Define AZURE_USERNAME and AZURE_PASSWORD as environment variables in CircleCI."
%}

## Cleaning Up is Missing

A complete solution should of course also clean up after itself and delete the branch environments when a branch is delete. CircleCI does unfortunately not support executing a job when a branch is deleted, so a more complicated solution would have to built. Other CI systems like GitLab's integrated CI/CD supports triggering jobs when branches are deleted, so hopefully CircleCI will add this feature too.

{% include previous-next.html
  previousHref="/blog/2019-06-12-part-3-local-test"
  previousText="Part 3: Local test"
  nextHref="/blog/2019-06-12-part-5-end-to-end-test"
  nextText="Part 5: End-to-end Test"
%}
