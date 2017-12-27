//
//  RNMobvistaView.h
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/25/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#if __has_include(<React/RCTComponent.h>)
#import <React/RCTView.h>
#else
#import "RCTView.h"
#endif

@interface RNMobvistaView : RCTView

- (void)loadMobvistaView;

@end
