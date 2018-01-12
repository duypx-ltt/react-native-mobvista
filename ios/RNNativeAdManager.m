//
//  RNNativeAdManager.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/27/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNNativeAdManager.h"
#import "RNNativeAdView.h"
#import "UIView+React.h"

@implementation RNNativeAdManager {
    RNNativeAdView *_nativeAdView;
//    NSString *_test;
}

RCT_EXPORT_MODULE();

- (UIView *)view
{
    // if (_nativeAdView == nil) {
        _nativeAdView = [[RNNativeAdView alloc] init];
    // }

    return _nativeAdView;
//    return [RNNativeAdView new];
//    return [UILabel new];
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_VIEW_PROPERTY(text, NSString)

RCT_EXPORT_VIEW_PROPERTY(width, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(height, CGFloat)

RCT_EXPORT_METHOD(loadNativeAd) {
    [_nativeAdView loadNativeAd];
}

RCT_EXPORT_VIEW_PROPERTY(isVideo, BOOL)

RCT_EXPORT_VIEW_PROPERTY(onNativeAdsLoaded, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeAdsFailedToLoadWithError, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onMVMediaViewWillEnterFullscreen, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onMVMediaViewDidExitFullscreen, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeAdDidClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeVideoAdDidClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeAdClickUrlWillStartToJump, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeVideoAdClickUrlWillStartToJump, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeAdClickUrlDidJumpToUrl, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeVideoAdClickUrlDidJumpToUrl, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeAdClickUrlDidEndJump, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onNativeVideoAdClickUrlDidEndJump, RCTBubblingEventBlock)

//RCT_EXPORT_VIEW_PROPERTY(size, NSDictionary)

//- (void)setTest:(NSString*) test {
//    _test = test;
//}
@end
