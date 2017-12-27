import React, { Component } from 'react';
import {
  requireNativeComponent,
  UIManager,
  findNodeHandle,
  ViewPropTypes,
  NativeModules
} from 'react-native';

// const RNAppWallManager = NativeModules.RNAppWallManager;

const RNNativeAdView = requireNativeComponent('RNNativeAd', NativeAd, {
  // nativeOnly: {
  //   onPress: true
  // }
});


export default class NativeAd extends Component {

  constructor() {
    super();
  }

  componentDidMount() {
    // this.loadBanner();
  }

  loadBanner() {
    console.log("loadBanner NativeAd");
    // RNAppWallManager.loadBanner();
    // UIManager.dispatchViewManagerCommand(
    //   findNodeHandle(this._bannerView),
    //   UIManager.RNAppWallView.Commands.loadBanner,
    //   null,
    // );
  }

  render() {
    return (
      <RNNativeAdView
        {...this.props}
        ref={el => (this._bannerView = el)}
      />
    )
  }
}


