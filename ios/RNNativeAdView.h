//
//  RNNativeAdView.h
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/27/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#if __has_include(<React/RCTComponent.h>)
#import <React/RCTView.h>
#else
#import "RCTView.h"
#endif
#import <MVSDK/MVSDK.h>
#import <MVSDK/MVNativeAdManager.h>

@interface RNNativeAdView : RCTView <MVNativeAdManagerDelegate ,MVMediaViewDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onNativeAdsLoaded;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeAdsFailedToLoadWithError;
@property (nonatomic, copy) RCTBubblingEventBlock onMVMediaViewWillEnterFullscreen;
@property (nonatomic, copy) RCTBubblingEventBlock onMVMediaViewDidExitFullscreen;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeAdDidClick;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeVideoAdDidClick;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeAdClickUrlWillStartToJump;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeVideoAdClickUrlWillStartToJump;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeAdClickUrlDidJumpToUrl;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeVideoAdClickUrlDidJumpToUrl;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeAdClickUrlDidEndJump;
@property (nonatomic, copy) RCTBubblingEventBlock onNativeVideoAdClickUrlDidEndJump;

- (void)loadNativeAd;

@end
