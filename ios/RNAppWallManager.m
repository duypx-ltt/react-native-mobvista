//
//  RNAppWallManager.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/25/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNAppWallManager.h"
#import "RNMobvistaView.h"
#import <MVSDK/MVSDK.h>
#import <MVSDKAppWall/MVWallAdManager.h>

@implementation RNAppWallManager {
    RNMobvistaView *_mobvistaView;
}

RCT_EXPORT_MODULE();

- (UIView *)view
{
    if (_mobvistaView == nil) {
        _mobvistaView = [[RNMobvistaView alloc] init];
    }
    
    return _mobvistaView;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

//RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
RCT_EXPORT_METHOD(loadBanner)
{
    NSLog(@"loadBanner");
    [_mobvistaView loadMobvistaView];
}

@end
