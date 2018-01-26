//
//  RNMobvistaView.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/25/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNMobvistaView.h"

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#import <React/UIView+React.h>
#import <React/RCTLog.h>
#else
#import "RCTBridgeModule.h"
#import "UIView+React.h"
#import "RCTLog.h"
#endif

#import <MVSDK/MVSDK.h>
#import <MVSDKAppWall/MVWallAdManager.h>

#define KAppWallUnitID [[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Mobvista" ofType:@"plist"]] objectForKey:@"KAppWallUnitID"] ? [[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Mobvista" ofType:@"plist"]] objectForKey:@"KAppWallUnitID"] : @"30106"

@implementation RNMobvistaView {
    UIView *_appWall;
    MVWallAdManager *_wallAdManager;
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
    _appWall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    _appWall.backgroundColor = [UIColor redColor];
    [self addSubview:_appWall];
    
    if (_wallAdManager == nil) {
            UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
            UIViewController *rootViewController = [keyWindow rootViewController];
        _wallAdManager = [[MVWallAdManager alloc] initWithUnitID:KAppWallUnitID presentingViewController:rootViewController];
    }
//    UIImage *image = [UIImage imageNamed:@"star-lighted"];
    [self.wallAdManager loadWallIconToView:_appWall withDefaultIconImage:[UIImage imageNamed:@"star-lighted"]];
}

- (void)layoutSubviews {
    NSLog(@"layout subviews");
}

- (void)loadMobvistaView {
    [_wallAdManager showAppWall];
}

- (MVWallAdManager *)wallAdManager
{
    //If the native ad manager is not existed, init it now.
    if (_wallAdManager == nil) {
        [self initAdManagerButtonAction:nil];
    }
    return _wallAdManager;
}

- (IBAction)initAdManagerButtonAction:(id)sender
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *rootViewController = [keyWindow rootViewController];
#warning Enter your App Wall UnitID here
    _wallAdManager = [[MVWallAdManager alloc] initWithUnitID:KAppWallUnitID presentingViewController:rootViewController];
}

@end
