---
layout: post
title: "VSCode as git editor"
published: true
---

# Configure Visual Studio Code as Your git Editor

I use VSCode as my text editor for git, and keep having to search the for the right command to configure this every time I reinstall it, since it doesn't open up a new VSCode window by default.

```shell
git config --global core.editor "code --new-window --wait"
```
