---
layout: post
title: "What, How and Why Code Comments"
published: false
---

> TL;DR: A code comment that explain **what** some code does, can almost always be replaced by a simple refactor of the code. If a comment explains **how** the code works, make the comment redundant by rewriting the code. If a comment explains **why** a piece of code is written as it is, keep it.

In the 90's, [Javadoc](https://en.wikipedia.org/wiki/Javadoc) popularized the idea of documenting every little piece of your code. In most cases that's way too many comments, and I guess that's why the current trend seems to be to not write any comments at all, sometimes citing Uncle Bob ["a comment is a failure to express yourself in code"](https://twitter.com/unclebobmartin/status/870311898545258497). But avoiding code comments is very different from not writing any comments at all, [as he has also clarified himself](https://twitter.com/unclebobmartin/status/1317048589286330375). I believe that good comments are a crucial part of good code.

So. Some comment are good and some are bad, but how do you tell the apart? Well, categorizing then into what-, how- or why-comments can help.

Do not use these guidelines as rules.

## Three Types of Comments

Comments can be categorized into tree types why-comments, how-comments and what-comments.

1. **What-comments** explain what the code does.
1. **How-comments** explain how the code works.
1. **Why-comments** explain why the code was written as it is.

## What-Comments: Remove Them

Code comments that explain **what** the code does can almost always be made redundant with a simple refactoring of the code. You should strive to write self-documenting code instead of using what-comments.

Example:

```typescript
// BAD
// Escape key.
if (event.keyCode === 43) {
  closeDialog();
}
```

```typescript
// GOOD
enum KeyCode {
  Escape: 43
}

if (event.keyCode === KeyCode.Escape) {
  closeDialog();
}
```

```typescript
// Validate
function validate(password) {
  const isValid = password.length >= 8
  return isValid
}
```

```typescript
function isLongEnough(password) {
  const longEnough = password.length >= MINIMUM_PASSWORD_LENGTH
  return longEnough
}
```

```typescript
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

If you just figured something out, and think that the next programmer looking at the piece of code will have the same troubles, then be courteous and put a helpful comments, possibly with a link to an article or a answer on Stack Overflow that explains things are like so.

* CSS browser hacks. `/* Required by IE 9. */` or `/* Element gets a */`
* Couldn't figure it out, but this works.
* Badly named variables in APIs.

https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting

## TODO: Where To Put The Lines Below?

Comments are put there to make the code easier to read. If you have hard time grasping a piece of code, consider leaving a comment for the next developer.

Write full sentences with proper capitalization and punctuation.

Keep in mind that these are guidelines and not rules. There will always be situations where you shouldn't follow these guidelines.

Self documenting code.
