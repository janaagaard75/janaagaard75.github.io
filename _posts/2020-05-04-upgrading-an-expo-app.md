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

This is how I upgrade my [Expo](https://expo.io/) apps. My apps use [Expo's Managed workflow](https://docs.expo.io/introduction/managed-vs-bare/?redirected#workflow-comparison).

I create a commit after each step, so that I can easily undo or debug, if necessary, and I generally test running the app after each stop to make sure it still work. Upgraded packages sometimes require minor changes to the code.

## 1. Upgrade Expo CLI

The Expo CLI will do the most of the work upgrading the app, so start out by making sure I have the latest version of that command line tool.

```sh
yarn upgrade expo-cli
```

## 2. Upgrade Expo and Related NPM Packages

Expo CLI will upgrade the version numbers in `package.json` for all the packages that Expo use, respecting Expo's specific version requirements. Install the upgraded versions and run a yarn upgrade to make sure all the dependencies of our dependencies have been upgraded. I don't think Yarn has a command for doing `yarn install && yarn upgrade` in a single step.

```sh
yarn expo upgrade
yarn install
```

## 3. Upgrade the Rest of the Packages

Upgrade the rest of the npm packages.

```sh
yarn upgrade
```

## 4. Sync Versions from yarn.lock

I like being able to see the exact version of the packages that I have installed. This will synchronize the versions from `yarn.lock` to `package.json`. Reinstall afterwords to write the updated version numbers back to `yarn.lock`.

```
npx syncyarnlock --keepPrefix --keepGit --keepLink --save
yarn install
```

`syncyarnlock` should not change the version of `react-native` away from Expo's specific one, but there seems to be a bug in it. Revert that line in `package.json` if is was modified.

## 5. Align @types Packages

Align the `@types/` packages with the ones installed. Example: If `react` is on version `16.9.0` and `@types/react` is on version `16.8.something`, I manually update `@types/react` to version `~16.9.0`. The tilde will make sure to grab the latest `19.9.*` version.

This will require yet another around of installing, upgrading and sync'ing version numbers.

```sh
yarn install
npx syncyarnlock --keepPrefix --keepGit --keepLink --save
yarn install && yarn upgrade
```

## 6. Major Upgrade

`yarn upgrade` doesn't upgrade packages to new major versions. Verify if there is anything not up to date, and if so, consider upgrading. Upgrading major versions might require a lot of changes to the code.

```sh
yarn outdated
```

## 7. Final Install & Upgrade

This shouldn't be necessary, but I always run a final install and upgrade to make sure `package.json` and `yarn.lock` are in sync.

```sh
yarn install && yarn upgrade
```
