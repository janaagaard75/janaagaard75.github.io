---
layout: post
title: "Azure Functions in TypeScript"
date: 2019-03-01
categories:
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

Azure Functions are Microsoft's take on serverless computing and they correspond to Amazon's AWS Lambda and Google's Cloud Functions. Microsoft support a range of languages, but in version 2 TypeScript is only ["supported through transpiling to JavaScript"](https://medium.com/r/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fazure-functions%2Ffunctions-versions%23languages), and they don't provide any information about how to set up this up. I'm a big fan of TypeScript, so I have documented one way to this, and this article series will take you along on the journey.

{% Figure
  src: "/images/typescript-support.png"
  alt: "TypeScript support through transpiling"
  caption: "This is pretty much the only thing mentioned about TypeScript for version 2 of Azure Functions."
%}

Part 1 goes through installing the prerequisites and creating an HTTP endpoint function in JavaScript.

If you already know about Azure Functions, skip ahead to part 2, where the function is converted to TypeScript.

In the 3rd part a test is added and CircleCI is used to run the test automatically in a continuous integration pipeline. The code is then refactored, cleaning it up a bit.

Part 4 extends the continuous integration pipeline into a continuous delivery pipeline, add a few steps where the code is automatically published to Azure.
The final and 5th part adds an end-to-end test that verifies the endpoint on Azure.

The code relates to this article series is available as public domain (MIT licensed) at <https://github.com/janaagaard75/azure-fuctions-typescript>.

Keywords: Azure, serverless, Azure Functions, TypeScript, CircleCI, ARM templates, continuous delivery.
