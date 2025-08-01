---
layout: post
title: "Part 6: Refactor"
tags:
  - Prettier
  - TypeScript
published: false
---

This is the 6th part of the series about writing an serverless Azure Function in TypeScript. Since we now have and end-to-end test up and running we will refactor the code, cleaning it up a bit.

*"Make it work, make it right, make it fast."*<br>
-- Kent Beck

We have the first part, a working endpoint. Now we make it right.

[The code after is has been refactored](https://github.com/janaagaard75/azure-functions-typescript/tree/part-6-refactor).

## Turn On Strict Mode

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/aea4f43dedbfc8eb3aaa7041031400702fedcfa8)

The first thing we do is turn on TypeScript's strict mode, enabling a range of compile-time checks. You should always strive to enable this when using TypeScript, and when starting from scratch there really shouldn't be any excuse for not enabling this.

`noImplicitAny` is one of those checks, requiring that we specify the types of our parameters. For now we settle for simply adding `any` everywhere.

## Return the HTTP Response

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/3e63b53c53312eddfbc9289b1e5364291be8d134)

Return the HTTP response from the function instead of setting `context.res` to have a functional style instead of a side effect. This change simplifies out test code a bit.

I don't know why the demo function app defaults to using a side effect, and this changes seems like such an obvious improvement to the code, that I wonder, if there is some drawback to using the functional approach that I haven't yet realized.

## Use Strong Types

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/a2f1929e5ef6bd817795e24349fbc55d909bcae7)

We satisfied the compiler by setting the types to `any`, but we can do better and install type definitions for Azure Functions, available in the `@azure/functions` package. The package doesn't include a type for the HTTP response, so here we still use any, `Promise<any>`.

Using strong types in out tests requires that we mock the arguments we pass in. The best package I could find was [@fluffy-spoon/substitute](https://github.com/ffMathy/FluffySpoon.JavaScript.Testing.Faking). That package doesn't support `strictNullChecks`, so now we unfortunately have to cast a few objects to `any` in our test. As the author of the package suggests, we could turn off strictNullChecks for our tests, but that approach probably requires that the test files are located in a separate folder.

## Rename to greet

[Commit: Rename to greet](https://github.com/janaagaard75/azure-functions-typescript/commit/2860989a2a1e03dd044b6ec2ef51cc8e10e25f92)<br>
[Commit: Rename to greet.ts](https://github.com/janaagaard75/azure-functions-typescript/commit/a436c378e0bd868afc4638398a78edcb24bbef41)

Avoid having a lot of methods named `index` and avoid having a lots of `index.ts` files.

## Deterministic Behavior

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/c616d99978a074ebbb12da90eeaae31410daebe4)

Delete the destination folder before building to make sure that delete and renamed source files are also deleted in the `dist` folder.

The packages are installed with the `--frozen-lockfile` modifier, so that installation fails, if `yarn.lock` has to be updated. This is how we want our continuous integration to behave, since we want to make sure that the packages installed are the ones specified by `yarn.lock`.

`rimraf` is simply a cross platform version of `rm -rf`, the Unix command for deleting a folder including all subfolders.

## Format the Code

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/540a238b5168b6fdcbc2a01afa4d88120571ace8)

"Nobody likes what Prettier does to their own code, but everybody loves what Pretties does to everybody else's code.".<br>
- Source unknown -- drop me a line if you recognize this line

[Prettier](https://prettier.io/) is a source code formatter that seems to be getting a lot of traction. I don't agree with all their choices ([operators at the beginning of lines, please](https://github.com/prettier/prettier/issues/3806)) but consistently and well formatted is just easier to read.

I use a [Prettier extension for VSCode](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) and set `"editor.formatOnSave": true`, but you can also [use a pre-commit hooks to handle the formatting](https://prettier.io/docs/en/precommit.html).

## Lint the Code

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/a19affccbb054bb0118f1d3ce60bd43559d54bb4)

Use TSLint to verify that the code follow best practices. Since Prettier handles all of the cosmetic rules, these are turned off by extending the `"tslint-config-prettier"` ruleset.

The world seems to be switching to ESLint even for TypeScript, but I haven't investigated that yet.

## Don't Abbreviate 'request'

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/d33021c96801d2d381e5f626c9050f6764e1c51b)

I generally try to avoid using abbreviations because I think the code becomes more readable without them.

## Remove Unnecessary Log

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/94e14e28fb51335dbb0d0ff32118030cda2efe32)

Azure logs all incoming requests so there is no need to log a custom message too.

## Remove Unnecessary Comment

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/8604bba58b54417fb015d5ae69af27b64e997b1b)

Remove the commit since it isn't really necessary. This information should arguably be part of the documentation included with the type definitions.

## Extract Method

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/8fe121139f469b8afd277b81eda219d7c4c687b7)

Simplify the code nesting by extracting to a function. We can now avoid the `else`.

## Invert `if`

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/ea65bdaf3d4d526af5c30da5face56f9eace4eef)

Revert the `if` to reduce nesting. This also have the nice effect of putting the special case - no name defined - into the if clause, and letting the happy flow flow be the least indented one.

## Use String Interpolation

[Commit](https://github.com/janaagaard75/azure-functions-typescript/commit/1fe05262f015f67494150d6b565fd70e7de07b95)

Replace `+` with string interpolations making the code more readable. This also have the effect of making it more obvious that we need to terminate our sentence with a full stop.

{% include previous-next.html
  previousHref="/blog/2019-06-12-part-5-end-to-end-test"
  previousText="Part 5: End-to-end Test"
  nextHref="/blog/2019-06-12-part-7-node-module"
  nextText="Part 7: Node Module"
%}
