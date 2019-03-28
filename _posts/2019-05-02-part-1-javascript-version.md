---
layout: post
title: "Part 1: JavaScript Version"
published: false
---

We start out creating a basic HTTP endpoint written as an Azure Function in JavaScript. If you already know about Azure Functions, then skip ahead to [the next part](/blog/2019/05/03/part-2-switch-to-typescript) where the code is transformed into TypeScript.

## Install Prerequisites

Azure Functions require a long term support (LTS) version of **Node.js**. The versions with an even major version number are LTS versions, and version 10 is currently the latest. The following commands installs the latest version of Node 10 on macOS using Homebrew and makes it the default Node.js. Remember to re-link if you upgrade Node.js.

```bash
$ brew install node@10
$ brew link node@10 --force --overwrite
```

Install **Yarn**. Yarn is a better npm. I am particularly fund of the really fast installs on a project where the dependencies are up to date, because this allows you include yarn install as part of the build, making sure that you are always using the correct versions. We do this in part TODO.

```bash
$ brew install yarn
```

Install the command line tools for Azure Functions, **Azure Functions Core Tools**. This will add the `func` command to your shell. We install the tools use a local Node.js package instead of a global tool because we will be using the `func` command later on in our continuous integration pipeline. If you want to have the command available everywhere in your shell, I would recommend installing it with Homebrew, since that makes it easy to maintain the package together with Node.js and Yarn (`brew install azure-functions-core-tools`). If you're a team of developers, including the tools as developer dependencies makes it easy to keep everybody on the same version. It's fine having the command installed both locally and globally, should you prefer that.

I always install exact versions of the Node.js packages that I use (`--exact`) because I like being able to see the versions of the installed packages in `package.json`. With the command line tool [`npm-check-updates`](https://www.npmjs.com/package/npm-check-updates) installed you can upgrade all the packages with the command `ncu -u && yarn upgrade`. I recommend keeping upgrades in their own commits to make it easy to revert an upgrade, should it break something.

TODO: Is the `func` command required to be available globally by VSCode?

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

This results in the following folder structure. A few notes

- Each function must reside in it's own folder, one level below `host.json`.
- Each function must have a `function.json` file.
- `local.settings.json` are only used when hosting the functions locally. They are not copied to Azure when publishing.

```text
├── greet
│   ├── function.json
│   ├── index.js
│   └── sample.dat
├── node_modules
│   └── ...
├── host.json
├── local.settings.json
├── package.json
└── yarn.lock
```

## Hosting Locally

The local Azure Functions host is started with the command `yarn func host start`. The `yarn` prefix is necessary since the `func` command is installed locally. This is bit long to type, so we [add a `start` script command to `package.json`](https://github.com/janaagaard75/azure-functions-typescript/commit/10ad0215992cd18513d421dd8bf4b1629b68af5f). We can now start the local host with this command:

```bash
$ yarn start
```

Open a browser window, go to <http://localhost:4000/api/greet>, add a name as a query parameter, and you will see it echoed back.

{% include figure.html
  src="/images/running-on-localhost.png"
  alt="Browser window with output from the greet endpoint"
  caption="Our serverless HTTP triggered Azure Function in action. \o/"
%}

## Final Tweaks

- The endpoint is made available anonymously. This is just to make this setup simpler.

A handful of tweaks are made to enhance the development experience in [Visual Studio Code](https://code.visualstudio.com/).

- Launching and debugging the code within VSCode.
- Settings for the Azure Functions extension for VSCode. TODO: Test if this extension requires that the tools are installed globally.
- Format files when saving them.
- Default to indenting files with two spaces.
- Add settings for the Spell Right extension.

TODO: The code can be debugged in Visual Studio Code.

The [final code base for part 1 on GitHub](https://github.com/janaagaard75/azure-functions-typescript/tree/1-javascript-version). If you a curious about the changes made in these last tweaks, take a look at the [commit history](https://github.com/janaagaard75/azure-functions-typescript/commits/1-javascript-version).

[Part 2: Switch to TypeScript](/blog/2019/05/03/part-2-switch-to-typescript)
