# Readable Code

As I get older a have had experience with different code bases, my observance is that the most important factor for a piece of code is that is it easy to read.

I rate readablity higher than bug-free, because readablity is the most important factor in making code maintainable, and thus I generally find it it pretty easy to fix bugs in code that is easy to read.

## What is Readable Code?

## Naming Things

> There are only two hard things in Computer Science: cache invalidation and naming things.
>
> -- *[Phil Karlton][1]*

[1]:https://martinfowler.com/bliki/TwoHardThings.html

A key to writing readable code is to use unambigous names, so that when you read the code, you don't have to know the full context to understand it. A quick example is to always qualify IDs, so you never have a variable just named `id` - it's always `userId`, `noteId` etc.

Bob Nystrom's excellent [Long names are long](http://journal.stuffwithstuff.com/2016/06/16/long-names-are-long/) article have some great point on what to look for when chosing a name and some good examples. The only thing that I don't agree with is the angle the article takes, because in my experience variable names tend to be too short rather than too long. The principle in Bob's article still apply though, and it could just as well have been named *Short names are short*.

### Name Check List

* Avoid general names like `result`, `id`, or `value`.
* Avoid abbreviations like `res` and `e`.
  * Is `res` short for response, result, resolution or resize?
  * Is `e` short for error, exception or event?
* Never use single letter variable names, except for indexes `i`, `n` and likes in loops.
* Only include the type of the variable in the name, if you need to.

```typescript
const namesString = "Alice,Bob,Clark"
const namesArray = namesString.split(",")
```

### Renaming Existing Things

One source of ambiguity is that when you add stuff, you might have to rename some of the existing variables.

Original code:

```typescript
const localhostUrl = "http://localhost:9000/"
```

`localhostDocmergeUrl` was added, so now localhostUrl is no longer unambiguous.

```typescript
const localhostUrl = "http://localhost:9000/"
const localhostDocmergeUrl = "http://localhost:9001/"
```

Changing the existing name of the original variable removed the ambiguity:

```typescript
const localhostWebsiteUrl = "http://localhost:9000/"
const localhostDocmergeUrl = "http://localhost:9001/"
```

## Comments

See [Comments](comments.md).

Why Comments > How Comments > What Comments.

## Return Variables

Define a variable before returning. TODO: Verify if Chrome allows to access the variable in the console. It is possible to see it in the local variables window, but that is not a powerfull as having access to the value in the console.

    sum(a, b) {
      const sum = a + b
      return sum
    }

## Follow Existing Formatting Rules

Follow the existing whitespace rules that the code is using. This shouldn't really be an issue, because most of this should be locked down using linting rules, but not everything is linted, so look around in the code to get a feel for what the current standards are.

If you want to change something, you should change it throughout the solution.

*Our current solution has  weak linting setup, so you will often see more than one way of doing things. We really should fix this.*