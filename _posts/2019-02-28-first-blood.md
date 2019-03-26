---
layout: post
title: "First Blood Test Post"
date: 2019-02-28 12:05:10 +0100
published: true
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

You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

```ruby
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
```

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
