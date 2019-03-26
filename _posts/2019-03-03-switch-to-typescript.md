---
layout: post
title: "Part 2: Switch to TypeScript"
---

This is part two of the series about writing an Azure Function in TypeScript. In part 1 we created a basic HTTP triggered function written in JavaScript. In this part we switch to TypeScript.

To keep things organized we will put the source TypeScript files in a folder named `src` and we will be compiling into a distribution folder named `dist`.

The first step is simply moving the files and updating our start script to switch to that directory before start in the host.

```json
# In package.json
"start": "(cd src; func host start)"
```

We're now ready to transform to TypeScript. This will require installing the TypeScript compiler.

```bash
$ yarn add --exact --dev typescript
fdas
```

TypeScript is configured with a `tsconfig.json` file. Since the code is running on Node.js version 10 we can target ECMAScript 2018.

```json
# tsconfig.json:
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

We also need to update the function syntax a bit.

```typescript
// First line in index.ts
export async function run(context, req) {
```

And finally a new `build` command is added to `package.json`. The build command calls the TypeScript compiler, `tsc`, and copies the JSON files from `src` to `dist`.

```json
// In package.json:
"build": "tsc TODO"
```

TODO: The code can be debugged in Visual Studio Code.

TODO: Include a dependency to an npm package. Day.js? Something that already has type definitions. Do this in step 4.
