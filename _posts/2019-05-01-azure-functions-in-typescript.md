---
layout: post
title: "Azure Functions in TypeScript"
tags:
  [
    ARM templates,
    Azure Functions,
    Azure,
    CircleCI,
    continuous delivery,
    serverless,
    TypeScript,
  ]
---

Azure Functions are Microsoft's take on serverless computing&mdash;they correspond to Amazon's AWS Lambda and Google's Cloud Functions. Microsoft support a range of languages, but in version 2 TypeScript is only ["supported through transpiling to JavaScript"](https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions#languages), and they don't provide any information about how to set up this up. I'm a big fan of TypeScript, so I have documented one way to this, and this article series will take you along on the journey.

{% Figure
  src: "/images/typescript-support.png"
  alt: "TypeScript support through transpiling"
%}
This is pretty much the only thing mentioned about TypeScript for version 2 of Azure Functions. <a href="https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions#languages">Source</a>
{% endFigure %}

This article series has the following seven parts:

1. Install the prerequisites and create an HTTP endpoint function in JavaScript.

2. Convert the JavaScript function to TypeScript.

3. Add a local test and create a continuous integration pipeline that runs the test.

4. Extend the continuous integration pipeline into a continuous delivery pipeline, finally deploying the code to Azure.

5. Use the public endpoint on Azure to create an end-to-end test.

6. Refactor the code, now that we have test coverage.

7. Demonstrate how to use a Node package.

The code related to this article series is available at [github.com/janaagaard75/azure-functions-typescript](https://github.com/janaagaard75/azure-functions-typescript).
