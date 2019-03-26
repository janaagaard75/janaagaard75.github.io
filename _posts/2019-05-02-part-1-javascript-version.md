---
layout: post
title: "Part 1: JavaScript Version"
published: false
---

We start out with a basic HTTP endpoint written as an Azure Function in JavaScript. If you already know about Azure Functions, then skip ahead to the next part, where the code is transformed into TypeScript.

Azure Functions require a long term support (LTS) version of Node.js. The versions with an even major version number are LTS versions, and version 10 is currently the latest LTS version. The following commands installs the latest version of Node 10 on macOS using Homebrew. Since v10 isn't the latest, you have to link it manually after installing it. Remember to re-link if you upgrade Node.js. You can use nvm if you need multiple versions of Node.js on your system.

```bash
$ brew install node@10
$ brew link node@10 --force --overwrite
```

Install Yarn. Yarn is a better npm. I am particularly fund of the really fast installs on a project where the dependencies are up to date, because this allows you include yarn install as part of the build, making sure that you are always using the correct versions.

```bash
$ brew install yarn
```

Create a folder and install the command line tools for Azure Functions - that's the func command line tool. The Azure Functions Core Tools are also available on Homebrew, but we will be needing the package our continuous delivery pipeline, so including in package.json means the tools will automatically be installed when installing the other Node.js packages. If you're a team of developers, including the tools as developer dependencies can also make it easy to keep everybody on the same version.

```bash
$ mkdir azure-functions-typescript
$ cd azure-functions-typescript
$ yarn add --exact --dev azure-functions-core-tools
```

Initialize the project and create an HTTP triggered function called greet.

```bash
$ yarn run func init --worker-runtime node
$ yarn run func new --name greet --language JavaScript
# Press 8 to create an HTTP triggered function.
```

This results in the following folder structure.

```text
├── greet
│   ├── function.json
│   ├── index.js
│   └──sample.dat
├── node_modules
│   └── ...
├── host.json
├── local.settings.json
├── package.json
└── yarn.lock
```

Fire up the local Azure Functions host command func host start. Since the Azure Functions Core Tools are installed locally we would have to prefix this call with yarn. We simplify a bit by adding the start command as a run script in package.json (TODO: Link to commit), so that we simply type yarn start. This will make the endpoint available on <http://localhost:7071/api/greet>.

```bash
$ yarn start
```

Add a name as a query parameter, and you will see it echoed back.

Our serverless HTTP triggered Azure Function in action. \o/The function is made available anonymously, and a few more files are added to set up everything in Visual Studio Code, resulting in the final code available on GitHub: <https://github.com/janaagaard75/azure-functions-typescript/tree/1-javascript-version>. The commit tree explains what was added. (TODO: Link.)

Part 2: Converting to TypeScript. TODO: Link
