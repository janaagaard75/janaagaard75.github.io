# Writing Good Code Comments

Writing good code comments is part writing good code. A good comment can save the next developer hours of time, whereas a bad one can do just the opposite. This article introduces a system for classifying comments, which meant to help help you think about your comments, and in general improve your code.

Comments are put here for the next programmer. Write full sentenses with proper capitalization and punctuation.

TODO: Quote from Clean Code about comments being filler or simply plain wrong. “Well-documented“ quote.

The guidelines in here are meant as just that - guidelines - so keep in mind that there will always be situations where you shouldn't follow these.

## Three Types of Comments

Comments can be categorized into tree types, why-comments, how-comments and what-comments.

1. **What-comments** explain what the code does.
1. **How-comments** explain how the code works.
1. **Why-comments** explain why the code is what it is.

## What-Comments

What comments explain hat the code does. These kind of comment can generally always be replaced by writing self documented code instead.

You should strive to write self-documenting code.

TODO: Find a better example.

```javascript
// Return the sum of a and b.
function foo(a, b) {
return a + b
}
```

```javascript
function sum(a, b) {
return a + b
}
```

I think that some developers write placeholder comments for themselves when they start out, so that hey have an idea of what their code will like like, when they done. Great! Just remember to remove the comments before making the pull request.

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
