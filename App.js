import { useBackHandler } from '@react-native-community/hooks';
import React, { useRef } from 'react';
import WebView from 'react-native-webview';

const uri = __DEV__
  ? 'http://10.0.2.2:3000'
  : 'file:///android_asset/build/index.html';

const App = () => {
  const webview = useRef();

  useBackHandler(() => {
    if (!webview.current) {
      return false;
    }
    webview.current.goBack();
    return true;
  });

  return (
    <WebView
      ref={webview}
      source={{ uri }}
      allowFileAccess
      setBuiltInZoomControls={false}
      bounces={false}
    />
  );
};

export default App;
