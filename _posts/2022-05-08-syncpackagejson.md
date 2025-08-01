---
layout: post
title: "Keeping package.json in sync"
summary: "Synchronize the installed versions of Node.js dependencies into package.json."
tags:
  - npm
published: true
---

I like to be able to look up the exact version of the Node.js dependencies that I have installed. With Yarn I use [`syncyarnlock`](https://www.npmjs.com/package/syncyarnlock), but I couldn't find any equivalent tool for npm. So I wrote one.

[`syncpackagejson`](https://www.npmjs.com/package/syncpackagejson) synchronizes the installed versions of Node.js dependencies as specified in package-lock.json into package.json.

The package is intended to be used together with `npm upgrade`, like this.

```shell
npm upgrade && npx syncpackagejson && npm install
```

This is still very much a 1.0 release. When you find a bug or something missing, please [file an issue](https://github.com/janaagaard75/syncpackagejson/issues).
