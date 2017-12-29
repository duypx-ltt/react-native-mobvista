import React, { Component } from 'react';
import {
  requireNativeComponent,
  UIManager,
  findNodeHandle,
  ViewPropTypes,
  NativeModules,
  View
} from 'react-native';
import { PropTypes } from 'react';

const RNNativeAdManager = NativeModules.RNNativeAdManager;

const RNNativeAdView = requireNativeComponent('RNNativeAd', NativeAd, {
  // nativeOnly: {
  //   onPress: true
  // }
});

/**
 * Example: <NativeAd isVideo={true} style={{ flex: 1 }} />
 */

export default class NativeAd extends Component {

  constructor() {
    super();
  }

  componentDidMount() {
    // this.loadNativeAd();
  }

  handleOnNativeAdsLoaded = (event) => {
    if (this.props.onNativeAdsLoaded) {
      const { unitId } = event.nativeEvent;
      this.props.onNativeAdsLoaded({ unitId });
    }
  };

  handleOnNativeAdsFailedToLoadWithError = (event) => {
    if (this.props.onNativeAdsFailedToLoadWithError) {
      const { unitId, error } = event.nativeEvent;
      this.props.onNativeAdsFailedToLoadWithError({ unitId, error });
    }
  };

  handleOnMVMediaViewWillEnterFullscreen = (event) => {
    if (this.props.onMVMediaViewWillEnterFullscreen) {
      this.props.onMVMediaViewWillEnterFullscreen();
    }
  };

  handleOnMVMediaViewDidExitFullscreen = (event) => {
    if (this.props.onMVMediaViewDidExitFullscreen) {
      this.props.onMVMediaViewDidExitFullscreen();
    }
  };

  handleOnNativeAdDidClick = (event) => {
    if (this.props.onNativeAdDidClick) {
      this.props.onNativeAdDidClick();
    }
  };

  handleOnNativeVideoAdDidClick = (event) => {
    if (this.props.onNativeVideoAdDidClick) {
      this.props.onNativeVideoAdDidClick();
    }
  };

  handleOnNativeAdClickUrlWillStartToJump = (event) => {
    if (this.props.onNativeAdClickUrlWillStartToJump) {
      const { clickUrl } = event.nativeEvent;
      this.props.onNativeAdClickUrlWillStartToJump({ clickUrl });
    }
  };

  handleOnNativeVideoAdClickUrlWillStartToJump = (event) => {
    if (this.props.onNativeVideoAdClickUrlWillStartToJump) {
      const { clickUrl } = event.nativeEvent;
      this.props.onNativeVideoAdClickUrlWillStartToJump({ clickUrl });
    }
  };

  handleOnNativeAdClickUrlDidJumpToUrl = (event) => {
    if (this.props.onNativeAdClickUrlDidJumpToUrl) {
      const { jumpUrl } = event.nativeEvent;
      this.props.onNativeAdClickUrlDidJumpToUrl({ jumpUrl });
    }
  };

  handleOnNativeVideoAdClickUrlDidJumpToUrl = (event) => {
    if (this.props.onNativeVideoAdClickUrlDidJumpToUrl) {
      const { jumpUrl } = event.nativeEvent;
      this.props.onNativeVideoAdClickUrlDidJumpToUrl({ jumpUrl });
    }
  };

  handleOnNativeAdClickUrlDidEndJump = (event) => {
    if (this.props.onNativeAdClickUrlDidEndJump) {
      const { finalUrl, error } = event.nativeEvent;
      this.props.onNativeAdClickUrlDidEndJump({ finalUrl, error });
    }
  };

  handleOnNativeVideoAdClickUrlDidEndJump = (event) => {
    if (this.props.onNativeVideoAdClickUrlDidEndJump) {
      const { finalUrl, error } = event.nativeEvent;
      this.props.onNativeVideoAdClickUrlDidEndJump({ finalUrl, error });
    }
  };

  render() {
    return (
      <View style={{...this.props.style, width: "100%"}}>
        <RNNativeAdView
          { ...this.props }
          ref={ el => (this._bannerView = el) }
          onNativeAdsLoaded={ this.handleOnNativeAdsLoaded }
          onNativeAdsFailedToLoadWithError={ this.handleOnNativeAdsFailedToLoadWithError }
          onMVMediaViewWillEnterFullscreen={ this.handleOnMVMediaViewWillEnterFullscreen }
          onMVMediaViewDidExitFullscreen={ this.handleOnMVMediaViewDidExitFullscreen }
          onNativeAdDidClick={ this.handleOnNativeAdDidClick }
          onNativeVideoAdDidClick={ this.handleOnNativeVideoAdDidClick }
          onNativeAdClickUrlWillStartToJump={ this.handleOnNativeAdClickUrlWillStartToJump }
          onNativeVideoAdClickUrlWillStartToJump={ this.handleOnNativeVideoAdClickUrlWillStartToJump }
          onNativeAdClickUrlDidJumpToUrl={ this.handleOnNativeAdClickUrlDidJumpToUrl }
          onNativeVideoAdClickUrlDidJumpToUrl={ this.handleOnNativeVideoAdClickUrlDidJumpToUrl }
          onNativeAdClickUrlDidEndJump={ this.handleOnNativeAdClickUrlDidEndJump }
          onNativeVideoAdClickUrlDidEndJump={ this.handleOnNativeVideoAdClickUrlDidEndJump }
        />
      </View>

    )
  }
}

NativeAd.propsType = {
  text: PropTypes.string,
  size: PropTypes.object
}
