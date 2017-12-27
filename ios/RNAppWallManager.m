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
//    UIView *appWallView;
//    appWallView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    appWallView.backgroundColor = [UIColor redColor];
//    return appWallView;
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
//    [self.bridge.uiManager addUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, RNGADBannerView *> *viewRegistry) {
//        RNGADBannerView *view = viewRegistry[reactTag];
//        if (![view isKindOfClass:[RNGADBannerView class]]) {
//            RCTLogError(@"Invalid view returned from registry, expecting RNGADBannerView, got: %@", view);
//        } else {
//            [view loadBanner];
//        }
//    }];
//    [view loadBanner];
}

@end
