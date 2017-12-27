//
//  RNNativeAdView.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/27/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNNativeAdView.h"

#define KNativeUnitID @"30145"
#define KRewardVideo @"30146"
#define KPlacementID @""

@implementation RNNativeAdView {
    UIView *_mobvistaView;
}

- (instancetype)init {
    NSLog(@"init");
    self = [super init];
    if ( self ) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"init with frame: %@", NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if ( self ) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"init with coder: %@", aDecoder);
    self = [super initWithCoder:aDecoder];
    if ( self ) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _mobvistaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _mobvistaView.backgroundColor = [UIColor redColor];
    [self addSubview:_mobvistaView];
}

- (void)layoutSubviews {
    NSLog(@"layout subviews");
}

@end
