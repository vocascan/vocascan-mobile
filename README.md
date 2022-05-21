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

**APK**

Build an apk with `yarn build:apk`. It will be available in `outputs/android/apk` and can be installed through the adb with `yarn install:apk`.

> Note: APKs should only be used for testing. Build an android-app-bundle ([aab](https://developer.android.com/guide/app-bundle)) for production use.
