---
layout: post
title: "VSCode as git editor"
published: true
---

# Configure Visual Studio Code as Your git Editor

I use VSCode as my text editor for git, and every time I install git I have to search [for this comment on Stack Overflow](https://stackoverflow.com/questions/30024353/how-to-use-visual-studio-code-as-default-editor-for-git#comment-610442117) for the right command to configure this, since it doesn't open up a new VSCode window by default.

```shell
git config --global core.editor "code --new-window --wait"
```
