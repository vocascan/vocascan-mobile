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
