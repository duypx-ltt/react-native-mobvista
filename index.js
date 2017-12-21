import { NativeModules } from 'react-native';

const { RNReactNativeMobvista } = NativeModules;

export default {
  test: function () {
    return RNReactNativeMobvista.test;
  }
}
