import React from 'react';
import { SafeAreaView, StyleSheet, Platform } from 'react-native';
import WebView from 'react-native-webview';

const uri = __DEV__
  ? Platform.select({
      android: 'http://10.0.2.2:3000',
      default: 'http://localhost:3000',
    })
  : 'file:///android_asset/build/index.html';

const App = () => {
  return (
    <SafeAreaView style={styles.safeArea}>
      <WebView
        source={{ uri }}
        allowFileAccess
        setBuiltInZoomControls={false}
        bounces={false}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
});

export default App;
