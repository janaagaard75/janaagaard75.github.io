---
layout: post
title: "Part 2: Switch to TypeScript"
tags:
  [
    Azure Functions,
    Azure,
    serverless,
    TypeScript,
  ]
published: true
---

In this second part of the series about writing an Azure Function in TypeScript, the JavaScript function is converted to TypeScript. This is mainly setting up the TypeScript compiler. We won't make any changes until [part 6: Refactoring](/blog/2019), after the tests have been created.

If you prefer reading code, this is the [code base after part 2](https://github.com/janaagaard75/azure-functions-typescript/tree/part-2-switch-to-typescript).

## Compiling the TypeScript

To keep things organized we put the source files in a folder named `src` and we will be building into a distribution folder named `dist`.

```text
├── node_modules
│   └── ...
├── src
│   ├── greet
│   │   ├── function.json
│   │   ├── index.ts (renamed from .js)
│   │   └── sample.dat
│   ├── host.json
│   └── local.settings.json
├── package.json
└── yarn.lock
```

We're now ready to compile. This will require installing the TypeScript compiler.

```bash
$ yarn add --exact --dev typescript
```

The TypeScript compiler is configured with a `tsconfig.json` file.

- `module` and `moduleResolution` is configured to compile into JavaScript output that is compatible with the Azure Functions host.
- `outDir` and `rootDir` are the output and input folders.
- `sourceMap` means that we want TypeScript to generate map files along with the js files. This allows us to debug the TypeScript source files, instead of debugging the generated JavaScript files.
- `target` instructs the compiler to output JavaScript that is compatible with the very recent ECMAScript version 2018. This is possible since [Node.js version 10 supports ECMAScript 2018](https://node.green/#ES2018).

```javascript
// tsconfig.json
{
  "compilerOptions": {
    "module": "commonjs",
    "moduleResolution": "node",
    "outDir": "dist",
    "rootDir": "src",
    "sourceMap": true,
    "target": "es2018"
  }
}
```

Note that you strive to always turn on TypeScript strict mode that enables a handful of very nice compile time checks. We will do this when refactoring the code in [part 6](2019-06-12-part-6-refactor).

Building the solution consists of two things:

1. Compiling the TypeScript files and
2. copying the json files from `src` to `dist`.

We create a `build` command to handle this, and we update our `start` command so that the solution is built before starting the host. The start is also updated to switch to the `dist` folder.

```javascript
// In package.json
"scripts": {
  "build": "tsc && cp src/*.json dist && cp src/greet/*.json dist/greet",
  "start": "yarn run build && (cd dist; func host start)"
}
```

We still use `yarn run start` to start our local Azure host, but now the code is compiled first.

## Copying Files

The command for copying the json files `cp src/*.json dist && cp src/greet/*.json dist/greet` would have to be updated every time we add or rename a function. This is avoided by using the small [copyfiles](https://github.com/calvinmetcalf/copyfiles) command line tool.

```javascript
// In package.json
"build": "tsc && copyfiles --up 1 \"src/**/*.json\" dist",
```

Right now the build command is very simple, but as the project grows it might become beneficial to introduce a build tool like Webpack. We explore using Webpack in [part 7](2019-06-12-part-7-node-package).

{% include previous-next.html
  previousHref="/blog/2019-06-12-part-1-javascript-version"
  previousText="Part 1: JavaScript version"
  nextHref="/blog/2019-06-12-part-3-local-test"
  nextText="Part 3: Local Test"
%}
