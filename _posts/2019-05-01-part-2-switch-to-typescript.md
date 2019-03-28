---
layout: post
title: "Part 2: Switch to TypeScript"
published: false
---

In this second part of the series about writing an Azure Function in TypeScript, the JavaScript function is converted to TypeScript. This is mainly setting up the TypeScript compiler. We won't make any changes until [part 6: Refactoring](/blog/2019).

## Compiling the TypeScript

To keep things organized we put the source TypeScript files in a folder named `src` and we will be building into a distribution folder named `dist`. Create a `src` folder and move `host.json`, `local.settings.json` and the `greet` folder into it.

We're now ready to compile to TypeScript. This will require installing the TypeScript compiler.

```bash
$ yarn add --exact --dev typescript
```

The TypeScript compiled is configured with a `tsconfig.json` file. Since the code is running on [Node.js version 10 we can target ECMAScript 2018](https://node.green/#ES2018).

```json
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

Building the solution consists of two things: 1) compiling the TypeScript files and 2) copying the json files from `src` to `dist`. We add a `build` command to handle this, and we update our start command so that the solution is built before starting the host, and we switch to the `dist` folder before starting the host.

```json
// In package.json
"scripts": {
  "build": "tsc && cp src/*.json dist && cp src/greet/*.json dist/greet",
  "start": "yarn run build && (cd dist; func host start)"
}
```

TODO: Show build error and the fix.

TODO: The code can still be debugged because of `sourceMap`.
