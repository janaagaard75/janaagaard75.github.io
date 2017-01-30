# Why-, How- and What-Comments

This is a system for qualifying how good a code comment is. I use when determining if I should include a comment in my code, and I use when reviewing other peolple's code.

TODO: Full sentenses. Comments are put here for the next programmer. Good comments can same a lot of time. Bad comments are plain wrong or just fillers.

The guidelines in here are meant as just that - guidelines and not rules - so keep in mind that there will always be situations where you shouldn't follow the guidelines in here.

## Three Types of Comments

Comments can be categorized into tree types.

1. **Why-comments** explain why the code is what it is.
1. **How-comments** explain how the code works.
1. **What-comments** explain what the code does.

## Why-Comments

Why comments explain why the code is written in a specific way. This kind of comments are generally quite essential to understanding the code, and they should be encouraged.

If you just figured something out, and think that the next programmer looking at the piece of code will have the same troubles, then be curteous and put a helpful comments, possibly with a link to an article or a answer on Stack Overflow that explains things are like so.

* CSS browser hacks. `/* Required by IE 9. */` or `/* Element gets a  */`
* Couldn't figure it out, but this works.
* Badly named variables in APIs.

## How-Comments

Some comments explain how the code works. Regular Expressions always always require such a comments.

```javascript
// Require an ampersand and a dot.
const emailAddressValidator = /[^@]+@.+\.[^\.]+/;
```

## What-Comments

What comments explain hat the code does. These kind of comment can generally always be replaced by writing self documented code instead.

```javascript
sum(a, b) {
  return a + b
}
```

I think that some developers write placeholder comments for themselves when they start out, so that hey have an idea of what their code will like like, when they done. Great! But then remember to remove the comment.