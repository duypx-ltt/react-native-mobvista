//
//  RNRewardVideoManager.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/27/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNRewardVideoManager.h"
#import "RNRewardVideoView.h"

#if __has_include(<React/RCTBridge.h>)
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import <React/RCTEventDispatcher.h>
#else
#import "RCTBridge.h"
#import "RCTUIManager.h"
#import "RCTEventDispatcher.h"
#endif


@implementation RNRewardVideoManager {
    RNRewardVideoView *_rewardVideoView;
}

RCT_EXPORT_MODULE();

- (UIView *)view
{
    if (_rewardVideoView == nil) {
        _rewardVideoView = [RNRewardVideoView new];
    }
    
    return _rewardVideoView;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_VIEW_PROPERTY(onVideoAdLoadSuccess, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onVideoAdLoadFailed, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onVideoAdShowSuccess, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onVideoAdShowFailed, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onVideoAdDismissed, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onVideoAdClicked, RCTBubblingEventBlock)

RCT_EXPORT_METHOD(initRewardVideo)
{
    NSLog(@"initRewardVideo");
}

RCT_EXPORT_METHOD(loadRewardVideo)
{
    NSLog(@"loadRewardVideo");
}

RCT_EXPORT_METHOD(showRewardVideo)
{
    NSLog(@"showRewardVideo");
    [_rewardVideoView showRewardVideo];
}

@end
