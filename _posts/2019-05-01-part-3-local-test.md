---
layout: post
title: "Part 3: Local Test"
published: false
---

This is the third parts of a series about creating Azure Functions in TypeScript. In this part we will add a test using the [Jest](https://jestjs.io/) test framework and then use the [CircleCI](https://circleci.com/) continuous integration framework to run the test automatically.

## Writing the Test

Jest is an all-in-one test framework that includes the command line tool, the `expect` method and methods for writing fluent assertions.

```bash
$ yarn add --exact --dev jest ts-jest @types/jest
```

TODO: Why rename to `greet` now and not when doing the refactoring?

```typescript
// greet/index.test.ts
import { run as greet } from "./index";

describe("greet function", () => {
  test("returns correct greeting", async () => {
    const request = {
      query: {
        name: "Jan Aagaard"
      }
    };

    const context = {
      log: () => undefined,
      req: request
    };

    await greet(context, request);
    const response = (context as any).res;

    expect(response.body).toBe("Hello Jan Aagaard");
  });
});
```

Adding a test. Jest is a all-in-one framework that includes a test-runner, natural-language-checker. Mocha + Chai. Great Jest extension VSCode. It looks like Jest is becoming the de facto standard. TypeScript support.

TODO: Note on how much bigger node_modules becomes because of Jest.

## Running the Test Automatically

CircleCI `config.yml` file. How to determine the exact version of Node.js on Azure.

CircleCI requires JUNIT XML files, but Jest only supports JSON out of the box.

All the code minor code changes.

{% include previous-next.html
  previousHref="/blog/2019-05-01-part-2-switch-to-typescript"
  previousText="Part 2: Switch to TypeScript"
  nextHref="/blog/2019-05-01-part-4-continuous-delivery"
  nextText="Part 4: Continuous Delivery"
%}
