---
layout: post
title: "VSCode as git editor"
published: true
---

# Configure Visual Studio Code as Your git Editor

I use VSCode as my text editor for git, and every time I install git, I have to search [for a comment to answer on Stack Overflow](https://stackoverflow.com/a/36644561/37147) for the right command to configure this, since it doesn't open up a new VSCode window by default.

```shell
git config --global core.editor "code --new-window --wait"
```
