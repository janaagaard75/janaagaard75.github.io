---
layout: post
title: "Upgrading an Expo App"
tags:
  - Expo
  - upgrading Expo
  - upgrading Node packages
  - Yarn
published: true
---

This is how I upgrade my [Expo](https://expo.io/) apps like [React Native using Expo and Typescript](https://github.com/janaagaard75/expo-and-typescript). My apps use [Expo's Managed workflow](https://docs.expo.io/introduction/managed-vs-bare/?redirected#workflow-comparison) and use [Yarn v1](https://classic.yarnpkg.com/lang/en/) to manage npm packages.

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

## 3. Upgrade the Unknown Packages

Upgrade the unknown packages and any transitive dependencies that weren't touched by `expo upgrade`.

```sh
yarn upgrade
```

## 4. Major Updates to Unknown Packages

`yarn upgrade` doesn't upgrade packages to new major versions. Verify if there is anything not up to date, and if so, consider upgrading. For my Expo projects this is typically the ESLint related packages. I update the version manually in `package.json` and then run `yarn install`.

Some of the know packages might show up as deprecated, but do not updated those. Expo has been tested with specific versions of these packages, and they are naturally a little behind the latest releases.

```sh
# Look for major updates to unknown packages. These are the red lines, where the package was listed as unknown in step 1.
yarn outdated
```

## 5. Sync Installed Versions to `package.json`

I like being able to see the exact version of the packages that I have installed by looking in `package.json`, so I use [`syncyarnlock`](https://github.com/vasilevich/sync-yarnlock-into-packagejson) to synchronize the versions from `yarn.lock` to `package.json`. Run a `yarn install` after modifying `package.json` to sync the modifications back to `yarn.lock`.

```sh
npx syncyarnlock --keepPrefix --save && yarn install
```
