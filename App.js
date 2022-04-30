import React from 'react';
import WebView from 'react-native-webview';

const uri = __DEV__
  ? 'http://10.0.2.2:3000'
  : 'file:///android_asset/build/index.html';

const App = () => {
  return (
    <WebView
      source={{ uri }}
      allowFileAccess
      setBuiltInZoomControls={false}
      bounces={false}
    />
  );
};

export default App;
