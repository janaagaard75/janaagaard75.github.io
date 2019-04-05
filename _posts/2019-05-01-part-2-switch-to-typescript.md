---
layout: post
title: "Part 2: Switch to TypeScript"
published: false
---

In this second part of the series about writing an Azure Function in TypeScript, the JavaScript function is converted to TypeScript. This is mainly setting up the TypeScript compiler. We won't make any changes until [part 6: Refactoring](/blog/2019), after the tests have been created.

## Compiling the TypeScript

To keep things organized we put the source TypeScript files in a folder named `src` and we will be building into a distribution folder named `dist`. Create the src folder and move the two files and the folder `host.json`, `local.settings.json` and `greet` into it.

We're now ready to compile to TypeScript. This will require installing the TypeScript compiler.

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

## Copying Files

The command for copying the json files `cp src/*.json dist && cp src/greet/*.json dist/greet` would have to be updated every time we added or renamed a function. This can be avoided with the [copyfiles](https://github.com/calvinmetcalf/copyfiles) tool. Using it we can change the command to `copyfiles --up 1 \"src/**/*.json\" dist`.

```javascript
// In package.json
"build": "tsc && copyfiles --up 1 \"src/**/*.json\" dist",
```


## Webpack

Babel, type check, external modules.

TODO: Note about not using Webpack. <https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-node#dependency-management> and <https://github.com/liady/webpack-node-externals>

{% include previous-next.html
  previousHref="/blog/2019/05/01/part-1-javascript-version"
  previousText="Part 1: JavaScript version"
  nextHref="/blog/2019/05/01/part-3-local-test"
  nextText="Part 3: Local Test"
%}
