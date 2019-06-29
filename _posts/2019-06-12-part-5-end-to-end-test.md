---
layout: post
title: "Part 5: End-to-end Test"
published: true
---

Fifth part, adding an end-to-end test.

We just enabled automatic creation of branch environments in the previous step, so now let’s write a test that verifies that the code on Azure works.

Two groups of tests: Local tests run before publishing to Azure and end-to-end tests run after.

A local test fails the pipeline a lot faster than an end-to-end test, so keep most tests local tests. Our end-to-end test will only verify the happy path.

We retrieve the URL for the function app by going through the resource group. Since the name is directly based on the branch name, we could have simplified this step. This solution does not need to be updated if we change the way the URL for the function app is computed.

{% include previous-next.html
  previousHref="/blog/2019-06-12-part-4-continuous-deployment"
  previousText="Part 4: Continuous Deployment"
  nextHref="/blog/2019-06-12-part-6-refactor"
  nextText="Part 6: Refactor"
%}
