---
layout: post
title: "Azure Functions in TypeScript"
---

Azure Functions are Microsoft's take on serverless computing and they correspond to Amazon's AWS Lambda and Google's Cloud Functions. Microsoft support a range of languages, but in version 2 TypeScript is only ["supported through transpiling to JavaScript"](https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions#languages), and they don't provide any information about how to set up this up. I'm a big fan of TypeScript, so I have documented one way to this, and this article series will take you along on the journey.

{% Figure
  src: "/images/typescript-support.png"
  alt: "TypeScript support through transpiling"
%}
This is pretty much the only thing mentioned about TypeScript for version 2 of Azure Functions. <a href="https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions#languages">Source</a>
{% endFigure %}

Test

1. Part 1 goes through installing the prerequisites and creating an HTTP endpoint function in JavaScript.
2. If you already know about Azure Functions, skip ahead to part 2, where the function is converted to TypeScript.
3. In the 3rd part a local test is added and CircleCI is used to run the test automatically in a continuous integration pipeline. The code is then refactored, cleaning it up a bit.
4. Part 4 extends the continuous integration pipeline into a continuous delivery pipeline, finally deploying the endpoint to Azure and making it available online.
5. Now that endpoint is available online we can add an end-to-end test to the pipeline. This is done in the 5th part.
6. Now that we have a

The code relates to this article series is available as public domain (MIT licensed) at <https://github.com/janaagaard75/azure-fuctions-typescript>.

Keywords: Azure, serverless, Azure Functions, TypeScript, CircleCI, ARM templates, continuous delivery.
