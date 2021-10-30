---
layout: post
title: "Upgrading an Expo App"
tags:
  [
    Expo,
    upgrading Expo,
    upgrading Node packages,
    Yarn
  ]
published: true
---

This is how I upgrade my [Expo](https://expo.io/) apps ([React Native using Expo and Typescript](https://github.com/janaagaard75/expo-and-typescript), [Desert Walk Solitaire](https://github.com/janaagaard75/desert-walk) and [Skoleglæde.nu Bank](https://github.com/janaagaard75/skoleglaede-nu-bank)). My apps use [Expo's Managed workflow](https://docs.expo.io/introduction/managed-vs-bare/?redirected#workflow-comparison) and use [Yarn v1](https://classic.yarnpkg.com/lang/en/) to manage npm packages.

I create a commit after each step, so that I can easily undo or debug, if necessary, and I generally test running the app after each stop to make sure it still work. Upgraded packages sometimes require minor changes to the code.

## 1. Upgrade Expo CLI

The Expo CLI will do the most of the work upgrading the app, so start out by making sure I have the latest version of that command line tool.

```sh
yarn add --dev expo-cli@latest
```

## 2. Upgrade Expo and Known Packages

Expo CLI can upgrade Expo and all packages that it knows about, respecting Expo's specific version requirements. `expo upgrade` updates the version numbers in `package.json` and installs them afterwards to keep the `yarn.lock` in sync.

```sh
yarn expo upgrade
```

Make a note of the packages there weren't upgraded by Expo. Here's an example of the list of unknown packages.

```text
The following packages were not updated. You should check the READMEs for those repositories to determine what version is compatible with your new set of packages: @react-navigation/native, @react-navigation/stack, prop-types, tslib, @babel/core, @types/expo__vector-icons, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, eslint-config-prettier, eslint-plugin-prettier, eslint-plugin-react, expo-cli, prettier, sharp-cli
```

## 3. Upgrade the Rest of the Packages

Upgrade the rest of the npm packages.

```sh
yarn upgrade
```

## 4. Major Upgrades

`yarn upgrade` doesn't upgrade packages to new major versions. Verify if there is anything not up to date, and if so, consider upgrading. Upgrading major versions might require a lot of changes to the source code.

```sh
# Look out of major updates to unknown packages, that is red
# lines where the package is in the list found in step 1.
yarn outdated
```

## 5. Sync Versions from yarn.lock

I like being able to see the exact version of the packages that I have installed. `syntcyarnlock` can synchronize the versions from `yarn.lock` to `package.json`. Reinstall afterwords to write the updated version numbers back to `yarn.lock`, keeping the the file in sync with `package.json`.

```sh
npx syncyarnlock --keepPrefix --keepGit --keepLink --save
# Revert the change to the "react-native" line in package.json before installing.
yarn install
```

`syncyarnlock` should not change the version of `react-native` away from Expo's specific one, but there seems to be a bug. Revert that line in `package.json` if is was modified. It should look like this:

```jsonc
{
  // ...
  "dependencies": {
    // ...
    "react-native": "https://github.com/expo/react-native/archive/sdk-37.0.1.tar.gz",
    // ...
  }
  // ...
}
```

## 6. Align @types Packages

Definitely Typed packages don't always follow the versioning of the main packages, so there are a few @types packages where this simply isn't possible. When not, I grab the lastet @types package available.

Align the `@types/` packages with the ones installed. Example: If `react` is on version `16.9.0` and `@types/react` is on version `16.8.something`, I manually update `@types/react` to version `~16.9.0`. The tilde will make sure to grab the latest `16.9.*` version. Search for `react-native@` in `yarn.lock` to finde the installed version of React Native.

This will require yet another around of installing, upgrading and sync'ing version numbers.

```sh
# Update @types packages manually.
yarn install
npx syncyarnlock --keepPrefix --keepGit --keepLink --save
# Revert the change to the "react-native" line in package.json before installing.
yarn install && yarn upgrade
```
