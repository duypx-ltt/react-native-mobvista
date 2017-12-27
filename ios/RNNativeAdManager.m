//
//  RNNativeAdManager.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/27/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNNativeAdManager.h"
#import "RNNativeAdView.h"

@implementation RNNativeAdManager {
    RNNativeAdView *_mobvistaView;
}

RCT_EXPORT_MODULE();

- (UIView *)view
{
    if (_mobvistaView == nil) {
        _mobvistaView = [[RNNativeAdView alloc] init];
    }
    
    return _mobvistaView;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}



@end
