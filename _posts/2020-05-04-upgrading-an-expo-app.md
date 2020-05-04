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

I create a commit after each step, so that I can easily undo or debug, if necessary, and I generally test running the app after each stop to make sure it still work. Updated packages sometimes require minor changes to the code.

## 1. Update Expo CLI

Use Expo CLI to upgrade the app, so first make sure Update Expo CLI is the latest version.

I like have my tools installed locally instead of globally, because I sometimes switch between two computers, and this keeps them in sync. I would also recommend doing this if you're more than one developer on the app.

Update `package.json`, install the the update `expo-cli` and make sure that all dependencies are the latest and greatest.

```sh
ncu -u expo-cli
yarn install
yarn upgrade
```

## 2. Upgrade the App

The will update version numbers in `package.json` respecting that Expo needs specific versions of some of the libraries.

```sh
yarn expo upgrade
yarn install && yarn upgrade
```

## 3. Align @types Packages

Align the `@types/` packages with the ones installed, e.g. if `react-native` is on version `0.61.4` I set `@types/react-native` to version `^0.61.0`.

As always, install after making changes to `package.json`.

```sh
yarn install
```

## 4. Sync Versions from yarn.lock

I like being able to see the exact version of the packages that I have installed, so I synchronize my `package.lock` with the versions in `yarn.lock` using [`syncyarnlock`](https://github.com/vasilevich/sync-yarnlock-into-packagejson).

Run a final `yarn install && yarn upgrade` to make sure the versions numbers in `yarn.lock` match the ones in `package.json` and that all dependencies of dependencies are up-to-date.

```
yarn sync-from-yarn-lock
yarn install && yarn upgrade
```
