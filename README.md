# vocascan-mobile

## Development

```bash
# 1. Start metro bundler
yarn start

# 2. Connect emulator or physical device
# (Verify connection through `adb devices` or Xcode equivalent)

# 3. Install dev-app on device
yarn android
# or
yarn ios
```

You can either develop against the vocascan testing environment or start your own vocascan-frontend server (default). Change the `uri` variable in `App.js` accordingly.

## Building

Run `yarn build` to build everything. Outputs are placed into `outputs/`.

| **Platform** | iOS | Android (AAB) | Android (APK) |
| --- | --- | --- | --- |
| **Script** | *Not implemented* | `yarn build:android` | `yarn build:android:apk` |
| **Output Directory** | *Not implemented* | `outputs/android/bundle` | `outputs/android/apk` |

> **WARNING** Before publishing the android app, a custom keystore has to be created to sign it https://reactnative.dev/docs/signed-apk-android.

**Different Branch / Tag**

Use the option `--frontend-branch` (`-b`) to build a different frontend branch / tag. (Default: `main`)

Example:
```bash
yarn build -b v1.2.0
```

**Different Repository**

Use the option `--frontend-repository` (`-r`) to build a different frontend repository. (Default: `https://github.com/vocascan/vocascan-frontend.git`)

Example:
```bash
yarn build -r https://github.com/my-username/vocascan-frontend.git
```
