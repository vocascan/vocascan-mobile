import React from 'react';
import { Platform } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import WebView from 'react-native-webview';

const uri = __DEV__
  ? Platform.select({
      android: 'http://10.0.2.2:3000',
      default: 'http://localhost:3000',
    })
  : 'file:///android_asset/build/index.html';

const App = () => {
  const insets = useSafeAreaInsets();

  return (
    <WebView
      source={{ uri }}
      allowFileAccess
      setBuiltInZoomControls={false}
      bounces={false}
      onMessage={_event => {}}
      injectedJavaScript={`
        window.VOCASCAN_CONFIG = {
          ...window.VOCASCAN_CONFIG,
          safeAreaInsets: {
            top: ${insets.top},
            right: ${insets.right},
            bottom: ${insets.bottom},
            left: ${insets.left},
          },
        };

        const META_ID = 'vocascan-mobile-injected-meta'

        if (!document.getElementById(META_ID)) {
          const meta = document.createElement('meta');
          meta.id = META_ID
          meta.setAttribute('content', 'maximum-scale=1, user-scalable=no');
          meta.setAttribute('name', 'viewport');
          document.querySelector('head').appendChild(meta);
        }
      `}
    />
  );
};

export default App;
