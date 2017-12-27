//
//  RNRewardVideoView.h
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
#import <MVSDKReward/MVRewardAdManager.h>
#import <MVSDK/MVSDK.h>

@interface RNRewardVideoView : RCTView <MVRewardAdLoadDelegate,MVRewardAdShowDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onVideoAdLoadSuccess;
@property (nonatomic, copy) RCTBubblingEventBlock onVideoAdLoadFailed;
@property (nonatomic, copy) RCTBubblingEventBlock onVideoAdShowSuccess;
@property (nonatomic, copy) RCTBubblingEventBlock onVideoAdShowFailed;
@property (nonatomic, copy) RCTBubblingEventBlock onVideoAdDismissed;
@property (nonatomic, copy) RCTBubblingEventBlock onVideoAdClicked;

- (void)initRewardVideo;
- (void)loadRewardVideo;
- (void)showRewardVideo;


@end
