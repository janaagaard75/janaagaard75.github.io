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
published: false
---

Azure Functions are Microsoft's take on serverless computing---they correspond to Amazon's AWS Lambda and Google's Cloud Functions. Microsoft support a range of languages, but in version 2 TypeScript is only ["supported through transpiling to JavaScript"](https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions#languages), and they don't provide any information about how to set up this up. I'm a big fan of TypeScript, so I have documented one way to this, and this article series will take you along on the journey.

{% include figure.html
  src="/images/typescript-support.png"
  alt="TypeScript support through transpiling"
  caption="This is pretty much the only thing mentioned about TypeScript for version 2 of Azure Functions. <a href='https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions#languages'>Source</a>"
%}

## Seven Parts

Creating the Azure Function in TypeScript has been split into seven parts. If you already know about Azure Functions in JavaScript you might want to skip ahead to part 2. The tests are very simple, so part 3, 4 and 5 are mostly about configuring CircleCI and creating an ARM template. The 6th part, refactoring,was the most exciting one to write.

The source code related to this article series is [available on GitHub](https://github.com/janaagaard75/azure-functions-typescript).

- [Part 1: JavaScript version](/blog/2019/05/02/part-1-javascript-version). Install the prerequisites and create a serverless function in JavaScript triggered by HTTP.

- [Part 2: Switch to TypeScript](/blog/2019/05/03/part-2-switch-to-typescript). Convert the JavaScript function to TypeScript.

- [Part 3: Add a Test](/blog/2019/05/04/part-3-local-test). Add a local test and create a continuous integration pipeline that runs the test.

- [Part 4: Continuous Delivery](/blog/2019/05/05/part-4-continuous-delivery). Extend the continuous integration pipeline into a continuous delivery pipeline, finally deploying the code to Azure.

- [Part 5: Add an End-to-end Test](/blog/2019/05/06/part-5-end-to-end-test). Use the public endpoint on Azure to create an end-to-end test.

- [Part 6: Refactor](/blog/2019/05/07/part-6-refactor). Now that we have test coverage we can refactor the code with ease of mind.

- [Part 7: Use a Node.js Package](/blog/2019/05/08/part-7-node-package). Demonstrate how to use a Node.js package.
