---
layout: post
title: "Part 6: Refactor"
published: true
---

This is the 6th part of the series about writing an serverless Azure Function in TypeScript. Since we now have and end-to-end test up and running we will refactor the code, cleaning it up a bit.

"Make it work, make it right, make it fast."
-- Kent Beck

We have the first part, a working endpoint. Now we make it right.

## Strict mode

The first thing we do is turn on TypeScript's strict mode, enabling a range of compile-time checks. You should always strive to enable this when using TypeScript, especially when starting from scratch.

`noImplicitAny` is one of those checks, requiring that we specify the types of our parameters.

We can satisfy the compiler specifying the types as any, but we can do better and install the type definitions for Azure Functions, available in the `@azure/functions` package. The package doesn't include a type for the HTTP response, so here we fallback to using any, `Promise<any>`.

The package only contains type definitions, so it is only used when compiling the code, and therefore it should be installed as a development dependency. TSLint will however complain about importing a package from `devDependencies`, since it assumes that these packages are used when running the code. Installing the package as a normal dependency will satisfy TSLint, but once we start adding dependencies to Node.js packages in our code, we will need to install these on Azure too, and here we don't want the type definition package to be installed. So we loosen on TSLint's rule to get rid of the error.

- TODO: Note about `tslint` and devDependencies.
- TODO: `rimraf` to make it cross platform. "Writing posix command lines inside your scripts field will work regardless of the underlying operating system. This is because Berry will ship with a portable posix-like light shell that'll be used by default." <https://github.com/yarnpkg/yarn/issues/6953>. I haven't tested this on Windows, though, so if you find any issues, you're very welcome to add an issue or a pull request to the GitHub repo.
- Prettier. VSCode with `autoformatonsave=true`. There are a range of pre-commit hooks if you don't use VSCode. <https://prettier.io/docs/en/precommit.html>

Return the HTTP response instead of defining it on the context object, because this is a more functional coding style.

Strict mode FTW! This turns on a bunch of compile check features, one of them being that types can't implicitly be any. So we add the @azure/functions Node module. Microsoft hasn't published the types as a @types module. This is not HttpResponse so the best we can do is to set the type of the function to `Promise<any>`.

Deterministic behavior. `rimraf` is simply a cross platform version of `rm -rf`. Why `--frozen-lockfile`?

Prettier. "Nobody likes what Prettier does to their own code, but everybody loves what Pretties does to everybody else's code.".

Lint. Turning off the rules that Prettier takes care of. Running TSLint's recommended setup, but I still feel like tweaking a bit.

index.ts is renamed to greet.ts. This is done to avoid having lots of index.ts files in the code base.

{% include previous-next.html
  previousHref="/blog/2020-05-01-part-5-end-to-end-test"
  previousText="Part 5: End-to-end Test"
  nextHref="/blog/2020-05-01-part-7-node-package"
  nextText="Part 7: Webpack"
%}
