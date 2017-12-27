import React, { Component } from 'react';
import {
  requireNativeComponent,
  UIManager,
  findNodeHandle,
  ViewPropTypes,
  NativeModules
} from 'react-native';

const RNRewardVideo = requireNativeComponent('RNRewardVideo', RewardVideo, {});
const RNRewardVideoManager = NativeModules.RNRewardVideoManager;

export default class RewardVideo extends Component {

  constructor() {
    super();
  }

  componentDidMount() {
    // this.loadBanner();
  }

  loadBanner() {
    console.log("loadBanner RNRewardVideo");
  }

  showRewardVideo() {
    console.log("showRewardVideo");
    RNRewardVideoManager.showRewardVideo();
  }

  handleOnVideoAdLoadSuccess = (event) => {
    if (this.props.onVideoAdLoadSuccess) {
      const { unitId } = event.nativeEvent;
      this.props.onVideoAdLoadSuccess({ unitId });
    }
  };

  handleOnVideoAdLoadFailed = (event) => {
    if (this.props.onVideoAdLoadFailed) {
      const {unitId, error} = event.nativeEvent;
      this.props.onVideoAdLoadFailed({unitId, error});
    }
  };

  handleOnVideoAdShowSuccess = (event) => {
    if (this.props.onVideoAdShowSuccess) {
      const {unitId} = event.nativeEvent;
      this.props.onVideoAdShowSuccess({unitId});
    }
  };

  handleOnVideoAdShowFailed = (event) => {
    if (this.props.onVideoAdShowFailed) {
      const {unitId, error} = event.nativeEvent;
      this.props.onVideoAdShowFailed({unitId, error});
    }
  };

  handleOnVideoAdDismissed = (event) => {
    if (this.props.onVideoAdDismissed) {
      const {unitId, rewardName, rewardAmount} = event.nativeEvent;
      this.props.onVideoAdDismissed({unitId, rewardName, rewardAmount});
    }
  };

  handleOnVideoAdClicked = (event) => {
    if (this.props.onVideoAdClicked) {
      const {unitId} = event.nativeEvent;
      this.props.onVideoAdClicked({unitId});
    }
  };

  render() {
    return (
      <RNRewardVideo
        {...this.props}
        ref={el => (this._bannerView = el)}
        onVideoAdLoadSuccess={this.handleOnVideoAdLoadSuccess}
        onVideoAdLoadFailed={this.handleOnVideoAdLoadFailed}
        onVideoAdShowSuccess={this.handleOnVideoAdShowSuccess}
        onVideoAdShowFailed={this.handleOnVideoAdShowFailed}
        onVideoAdDismissed={this.handleOnVideoAdDismissed}
        onVideoAdClicked={this.handleOnVideoAdClicked}
      />
    )
  }
}


