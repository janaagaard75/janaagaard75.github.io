---
layout: post
title: "Part 3: Local Test"
published: false
---

This is the third parts of a series about creating Azure Functions in TypeScript. In this part we will add a test using the [Jest](https://jestjs.io/) test framework and then use the [CircleCI](https://circleci.com/) continuous integration framework to run the test automatically.

## Writing the Test

Since we're coding in TypeScript we also have to install `ts-jest` and `@types/jest`. (Side note: Installing Jest blows up the number of Node packages from 108 to 448.)

```bash
$ yarn add --exact --dev jest ts-jest @types/jest
```

This test creates fake `request` and `context` objects and calls the `run` function to verify that the response is indeed `Hello Jan Aagaard` as expected.

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

## Running the Test in Visual Studio Code

Installing the excellent [Jest extension for Visual Studio Code](https://marketplace.visualstudio.com/itemdetails?itemName=Orta.vscode-jest) will run the tests automatically in the background. The default setting is to only show a 'Debug' link above the tests that are failing, but I like being able to step into my code at any time. Adding the following line to `.vscode/settings.json` makes the 'Debug' link show permanently.

```javascript
// In .vscode/settings.json
"jest.debugCodeLens.showWhenTestStateIn": ["fail", "pass", "skip", "unknown"],
```

## Running the Test Automatically

CircleCI `config.yml` file. How to determine the exact version of Node.js on Azure.

CircleCI requires JUNIT XML files, but Jest only supports JSON out of the box.

{% include figure.html
  src="/images/circleci-environment-variables.png"
  alt="Environment variables defined in CircleCI"
  caption="Define AZURE_USERNAME and AZURE_PASSWORD as environment variables in CircleCI."
%}

{% include previous-next.html
  previousHref="/blog/2019-05-01-part-2-switch-to-typescript"
  previousText="Part 2: Switch to TypeScript"
  nextHref="/blog/2019-05-01-part-4-continuous-delivery"
  nextText="Part 4: Continuous Delivery"
%}
