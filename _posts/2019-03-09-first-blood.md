---
layout: post
title: "First Blood"
date: 2019-03-09
---

First post. Still following [Jonathan McGlone's Guide](http://jmcglone.com/guides/github-pages/).

```typescript
import { Context } from "@azure/functions";
import { HttpRequest } from "@azure/functions";

// Single line comment.
/* Multi line comment. */
/** Documentation comment. */
export async function run(
  context: Context,
  request: HttpRequest
): Promise<any> {
  const name = extractName(request);
  if (name === "") {
    return {
      body: "Please pass a name on the query string or in the request body",
      status: 400
    };
  }

  return {
    body: `Hello ${name}.`
  };
}

function extractName(request: HttpRequest): string {
  if (request.query.name) {
    return request.query.name;
  }

  if (request.body && request.body.name) {
    return request.body.name;
  }

  return "";
}
```
