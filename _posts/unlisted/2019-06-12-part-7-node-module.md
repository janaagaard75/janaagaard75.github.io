---
layout: post
title: "Part 7: Node Module"
published: true
unlisted: true
---

In this seventh and last part the code is updated to use a Node package. We add a new endpoint `/daystochristmas` that returns the number of days to Christmas Eve, calculated using [Day.js](https://github.com/iamkun/dayjs).

[The code after this part](https://github.com/janaagaard75/azure-functions-typescript/tree/part-7-node-module)

## Node Module

Using a Node Module in our code obviously requires installing it:

```shell
yarn install dayjs
```

Azure does not automatically install Node modules*, so we have to include the files added to `node_modules` in the `dist` folder. We will do this by copying `package.json` and `yarn.lock` to the `dist` folder and then install Node modules with the `--production` switch. That way only the modules listed as `dependencies` are installed - `devDependencies` are ignored.

*) Under some circumstances Azure does install the Modules. TODO: Find and link to this.

## Time Traveling in the Tests

Since the number of days until Christmas Eve, depends on the current date, our new endpoint is not deterministic, in that tomorrow it will return another value than today. This makes it a little challenging to write a test.

The solution chosen here is to use time traveling: Instead of running the tests is the context of the current date we will set the date explicitly when running them. We could rewrite out code to make it possible to inject the current time into the methods that we need to test, but fortunately we can also overwrite what `Date.now()` returns. That way, all we have to do, it to remember to use `Date.now()` when we want the current time.

The snippet below uses Jest to make `Date.now()` be based on the 20th of January 2019 at 10:22, making it return `1547979720000` regardless of the current date and time.

```typescript
jest
  .spyOn(Date, "now")
  .mockImplementation(
    () => new Date("2019-01-20T10:22:00").getTime()
  );
```

## More Refactoring

There are some more refactoring commits in this part that should be moved into the previous part, or simply fixup'ed into the other commits.

{% include previous-next.html
  previousHref="/blog/2019-06-12-part-6-refactor"
  previousText="Part 6: Refactor"
%}
