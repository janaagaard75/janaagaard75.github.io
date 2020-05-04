# Upgrading Expo

This is how I update my Expo app. I create a commit after each step, so that I can easily undo or debug, if necessary.

I generally test running the app after each stop to make sure it still work. Updating sometimes require minor changes to the code.

## 1. Update Expo CLI

Use Expo CLI to upgrade the app, so first make sure Update Expo CLI is the latest version.

1) Update `package.json`, 2) install the the update `expo-cli` and 3) make sure that all dependencies are the latest and greatest.

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

## 4. Final Upgrade

Run one last final upgrade to make sure that the dependencies of the dependencies have been installed.

```
yarn upgrade
```

## 5. Sync Versions from yarn.lock

I like being able to see the exact version of the packages that I have installed, so I synchronize my `package.lock` with the versions in `yarn.lock` using [`syncyarnlock`](TODO).

```
yarn sync-from-yarn-lock
yarn install && yarn upgrade
```
