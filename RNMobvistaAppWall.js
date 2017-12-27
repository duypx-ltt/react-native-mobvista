import React, { Component } from 'react';
import {
  requireNativeComponent,
  UIManager,
  findNodeHandle,
  ViewPropTypes,
  NativeModules
} from 'react-native';

const RNAppWallManager = NativeModules.RNAppWallManager;

const RNAppWallView = requireNativeComponent('RNAppWall', AppWall, {
  // nativeOnly: {
  //   onPress: true
  // }
});


export default class AppWall extends Component {

  constructor() {
    super();
  }

  componentDidMount() {
    // this.loadBanner();
  }

  loadBanner() {
    console.log("loadBanner");
    RNAppWallManager.loadBanner();
    // UIManager.dispatchViewManagerCommand(
    //   findNodeHandle(this._bannerView),
    //   UIManager.RNAppWallView.Commands.loadBanner,
    //   null,
    // );
  }

  render() {
    return (
      <RNAppWallView
        {...this.props}
        ref={el => (this._bannerView = el)}
      />
    )
  }
}


