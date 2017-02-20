# Writing Good Code Comments

You should strive to write code that doesn't need comments to explain it, but this doesn't mean you shouldn't be writing any comments at all. This article introduces a system for classifying most comments into three categories, meant to help you think about them, and in general improve your code.

Comments are put there for the next programmer. Write full sentenses with proper capitalization and punctuation.

Keep in mind that what is listed in here is guidelines and not rules. There will always be situations where you shouldn't follow these guidelines.

## Three Types of Comments

Comments can be categorized into tree types, why-comments, how-comments and what-comments.

1. **What-comments** explain what the code does.
1. **How-comments** explain how the code works.
1. **Why-comments** explain why the code is what it is.

## What-Comments

What comments explain hat the code does. These kind of comment can nearly always be replaced by writing self documented code instead. You should strive to write self-documenting code instead of using what-comments.

TODO: Find a better example.

```javascript
// Validate
function validate(password) {
  const isValid = password.length >= 8
  return isValid
}
```

```javascript
function isLongEnough(password) {
  const longEnough = password.length >= MIN_PASSWORD_LENGTH
  return longEnough
}
```

```javascript
/** The ID of the client. */
clientId
```

Exception: Structural comments, for example in your Webpack configuration file.

I think that some developers write placeholder comments in the code to help them the code while writing. Great! Just remember to remove the comments before making the pull request.

## How-Comments

Some comments explain how the code works. Regular Expressions always always require such a comments.

```javascript
// Require an ampersand and a dot.
const emailAddressValidator = /[^@]+@.+\.[^\.]+/;
```

## Why-Comments

Why comments explain why the code is written in a specific way. This kind of comments are generally quite essential to understanding the code, and they should be encouraged.

If you just figured something out, and think that the next programmer looking at the piece of code will have the same troubles, then be curteous and put a helpful comments, possibly with a link to an article or a answer on Stack Overflow that explains things are like so.

* CSS browser hacks. `/* Required by IE 9. */` or `/* Element gets a */`
* Couldn't figure it out, but this works.
* Badly named variables in APIs.