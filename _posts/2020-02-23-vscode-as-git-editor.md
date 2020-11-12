---
layout: post
title: "Configure Visual Studio Code as Your git Editor"
published: true
---

I use VSCode as my text editor for git, and every time I install git I have to search [for this comment on Stack Overflow](https://stackoverflow.com/questions/30024353/how-to-use-visual-studio-code-as-default-editor-for-git#comment-610442117) for the right command to configure this, since it doesn't open up a new VSCode window by default.

```shell
git config --global core.editor "code --new-window --wait"
```

## Installing git on Windows

{% include figure.html
  src="/images/set-default-git-editor-when-installing-on-windows.png"
  alt="Set default git editor when installing on Windows"
  caption="The default git editor can be set when installing on Windows. Click on Test Custom Editor to enable the Next button."
%}
