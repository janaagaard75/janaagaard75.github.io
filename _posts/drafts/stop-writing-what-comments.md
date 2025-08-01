---
layout: post
title: "Stop writing what comments"
summary: "A code comment that explain what some code does, can almost always be replaced by a simple refactor of the code. If a comment explains how the code works or especially why it was written as it is, keep it."
published: false
---

> TL;DR: A code comment that explain **what** some code does, can almost always be replaced by a simple refactor of the code. If a comment explains **how** the code works or especially **why** it was written as it is, keep it.

In the 90's, [Javadoc](https://en.wikipedia.org/wiki/Javadoc) popularized the idea of documenting every little piece of code. In most cases that's way too many comments, so the pendulum swung the other way, and in the 2010's it became common to not write any comments at all. With the arrival of agents generating code, it seems that we once again starting seeing a lot of unnecessary code comments.

I believe that good comments are a crucial part of good code.

> Not writing any comments is sometimes justified by citing Uncle Bob ["A comment is a failure to express yourself in code"](https://twitter.com/unclebobmartin/status/870311898545258497). But this taking his quote out of context, since it misses the second part **"If you fail, then write a comment; but try not to fail."**. [He also clarified this even further](https://twitter.com/unclebobmartin/status/1317048589286330375).

So. Some comment are good and some are bad, but how do you tell the apart? Well, categorizing then into what-, how- or why-comments can help.

Remember that these are guidelines &mdash; not rules.

## Three types of comments

Comments can usually be categorized into three types: why-comments, how-comments and what-comments.

1. **What-comments** explain what the code does.
1. **How-comments** explain how the code works.
1. **Why-comments** explain why the code was written as it is.

## What-comments: Remove them

Code comments that explain **what** the code does can almost always be made redundant with a simple refactoring of the code. You should strive to write self-documenting code instead of using what-comments.

Defining a constant can avoid the need for a what-comment:

```typescript
// Check for the escape key.
if (event.keyCode === 43) {
  closeDialog();
}
```

```typescript
const escapeKeyCode = 43;

if (event.keyCode === escapeKeyCode) {
  closeDialog();
}
```

Avoiding a generic function name can also help:

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

This comment doesn't add any value, and should just be removed:

```csharp
/// <summary>
/// The ID of the client.
/// </summary>
int ClientId { get; set; }
```

Exception: Structural comments, for example in your Webpack configuration file.


I think that some developers write placeholder comments in the code to help them the code while writing. Great! Just remember to remove the comments before making the pull request.

## How- and why-comments: Keep them

Some comments explain how the code works. Regular Expressions always always require such a comments.

```javascript
// Matches http(s)://domain.com/path?query=value or www.domain.com/path?query=value.
const urlExtractor = /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)/g;
```

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
