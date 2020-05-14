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

The Expo CLI will do the most of the work upgrading the app, so I start out by making sure I have the latest version of the tool.

I like having my tools installed locally instead of globally because I switch between two computers, and this keeps the tools in sync. I would also strongly recommend installing tools locally if you're more than one developer on the app. This also simplifies setting up new developer PCs.

`ncu` is the command that comes with [`npm-check-updates`](https://github.com/raineorshine/npm-check-updates). It can be used to check and update the version numbers of the npm packages `package.json`.

Upgrade `package.json`, install the upgraded `expo-cli` and make sure that all dependencies are the latest and greatest.

```sh
ncu -u expo-cli
yarn install
yarn upgrade
```

## 2. Upgrade Expo and Related Packages

The will upgrade version numbers in `package.json` for all the packages that Expo use, respecting Expo's specific version requirements.

```sh
yarn expo upgrade
yarn install
```

## 3. Sync Versions from yarn.lock

I like being able to see the exact version of the packages that I have installed, and `yarn upgrade` almost certainly bumped the version number for some of the packages, so I synchronize my `package.lock` with the versions in `yarn.lock` using [`syncyarnlock`](https://github.com/vasilevich/sync-yarnlock-into-packagejson).

```
yarn sync-from-yarn-lock
yarn install
```

## 4. Upgrade Non-Expo Packages

I use the [`npm-check-updates](https://github.com/raineorshine/npm-check-updates) to see if there are other packages that needs to be upgraded. `ncu` will also show updates to packages that Expo depend on, so do not update anything that `yarn expo upgrade` took care of.

```sh
yarn ncu
```

If it turns out that Prettier and Dayjs needs to be upgraded I run these commands:

```sh
yarn ncu -u prettier dayjs
yarn install
```

## 5. Align @types Packages

Align the `@types/` packages with the ones installed, e.g. if `react-native` is on version `0.61.4` I set `@types/react-native` to version `^0.61.0`. The caret will make sure to grab the latest `0.61.*` version.

Always run `yarn install` after making changes to version numbers `package.json` to make sure that `yarn.lock` is matches `package.json`.

```sh
yarn install
```

## 6. Final Yarn Upgrade

This shouldn't really be necessary, but always run a final `yarn install`, `yarn upgrade` and `sync-from-yarn-lock` to make sure absolute everything is update to date and the versions numbers in `package.json` and `yarn.lock` match each other. If `sync-from-yarn-lock` makes changes to `package.json`, run `yarn install` and `yarn upgrade` again.

`yarn install && yarn upgrade` is simply runs `yarn install` first and then `yarn upgrade`.

```sh
yarn upgrade
yarn sync-from-yarn-lock
yarn install && yarn upgrade
```
