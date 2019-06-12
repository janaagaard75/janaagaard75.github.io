---
layout: post
title: "Part 3: Local Test"
published: true
---

This is the third parts of a series about creating Azure Functions in TypeScript. In this part we add a test using the [Jest](https://jestjs.io/) test framework and then use the [CircleCI](https://circleci.com/) continuous integration framework to run the test automatically each time code is pushed to GitHub.

TODO: Link to the code.

## Writing the Test

Since we're coding in TypeScript we also have to install `ts-jest` and `@types/jest` when installing `jest`.

```bash
$ yarn add --exact --dev jest ts-jest @types/jest
```

(Side note: Installing Jest blows up the number of Node packages from 108 to 448. These guys really like using packages.)

Our test is pretty straight forward: It creates fake `request` and `context` objects and calls the `run` function to verify that the response is indeed `Hello Jan Aagaard` as expected.

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

## Running the Tests in Visual Studio Code

The code base includes a script command to run the tests, so that they can be executed by typing `yarn test`. Instead of relying on an external command to run the tests, I recommend installing the excellent [Jest extension for Visual Studio Code](https://marketplace.visualstudio.com/itemdetails?itemName=Orta.vscode-jest). I will run the tests continuously in the background, and show the results in VSCode's status bar.

The default setting is to show a 'Debug' link above the tests that are failing, but I like being able to step into my code at any time. Adding the following line to `.vscode/settings.json` makes the 'Debug' link show permanently.

```javascript
// In .vscode/settings.json
"jest.debugCodeLens.showWhenTestStateIn": ["fail", "pass", "skip", "unknown"],
```

## Running the Tests When Pushing Commits

Instead of relying on that the developers remember to run the tests locally, we will set up a continuous integration pipeline that executes the tests and blocks the pull request, should any of them fail. [CircleCI](https://circleci.com/) is one of the options for automating builds when having code hosted on GitHub, and it seems like it's currently gaining a lot of traction. Create your CircleCI account by signing in via GitHub, and then create a `config.yml` file that configures pipeline. These are the steps in the pipeline:

1. Check out the code from GitHub.
2. Install the Node.js packages.
3. Build the code.
4. Lint the code.
5. Run the tests.

It isn't necessary to build the code before running the tests because `ts-jest` takes care of that when running them. But it's nice to include the build step anyways to catch any compile errors, and likewise we also include a lint step.

```yaml
# .circleci/config.yml
version: 2.1
jobs:
  build:
    docker:
      # Match the version in azure-resource.json. See https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-node#node-version.
      - image: circleci/node:10.14.1-stretch

    steps:
      - checkout

      - run:
          name: Install Node modules
          command: yarn install --frozen-lockfile

      - run:
          name: Build
          command: yarn run build

      - run:
          name: Lint
          command: yarn run lint

      - run:
          name: Run tests
          command: yarn run test
```

The final `config.yml` (TODO: Add link) has a few more steps, adding a cache of the `node_modules` folder to speed up the build time and presenting the test results in CircleCI.

1. Check out the code from GitHub.
2. **Restore cached `node_modules`.**
3. Install the Node.js packages.
4. **Cache `node_modules`.**
5. Build the code.
6. Lint the code.
7. Run the tests.
8. **Store test results in CircleCI.**

CircleCI requires that test results are stored as JUnit XML files, and Jest uses json by default. The command for saving the test results ended up being quite long.

```javascript
// In package.json
"test-save-results": "cross-env JEST_JUNIT_OUTPUT=test-results/test-results.xml jest --ci --runInBand --reporters=default --reporters=jest-junit"
```

{% include previous-next.html
  previousHref="/blog/2019-06-12-part-2-switch-to-typescript"
  previousText="Part 2: Switch to TypeScript"
  nextHref="/blog/2020-05-01-part-4-continuous-deployment"
  nextText="Part 4: Continuous Deployment"
%}
