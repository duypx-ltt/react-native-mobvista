//
//  RNRewardVideoView.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/27/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNRewardVideoView.h"

#define KRewardUnitID @"30146"
#define KRewardID @"8794"

@implementation RNRewardVideoView

-(void)layoutSubviews
{
    [super layoutSubviews];
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
    // UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    // UIImage *image = [UIImage imageNamed:@"star-lighted"];
    // imageHolder.image = image;
    // [self addSubview:imageHolder];
    [self initRewardVideo];
    [self loadRewardVideo];
}

- (void)initRewardVideo {
    [MVRewardAdManager sharedInstance];
}

- (void)loadRewardVideo {
    [[MVRewardAdManager sharedInstance] loadVideo:KRewardUnitID delegate:self];
}

- (void)showRewardVideo {
    if ([[MVRewardAdManager sharedInstance] isVideoReadyToPlay:KRewardUnitID]) {
        [self log:@"Show reward video ad"];
        
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIViewController *rootViewController = [keyWindow rootViewController];
        [[MVRewardAdManager sharedInstance] showVideo:KRewardUnitID withRewardId:KRewardID userId:@"" delegate:self viewController:rootViewController];
    }
    else {
        //We will help you to load automatically when isReady is NO
        
        [self log:[NSString stringWithFormat:@"No ad to show"]];
    }
}

#pragma mark - MVRewardAdLoadDelegate Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Load Reward Video Ad Success Delegate
- (void)onVideoAdLoadSuccess:(NSString *)unitId
{
    [self log:[NSString stringWithFormat:@"unitId = %@, load success", unitId]];
    if (self.onVideoAdLoadSuccess) {
        self.onVideoAdLoadSuccess(@{@"unitId": unitId});
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Load Reward Video Ad Failed Delegate
- (void)onVideoAdLoadFailed:(NSString *)unitId error:(NSError *)error
{
    [self log:[NSString stringWithFormat:@"unitId = %@, load failed, error: %@", unitId,  error]];
    if (self.onVideoAdLoadFailed) {
        self.onVideoAdLoadFailed(@{@"unitId": unitId, @"error": [error localizedDescription]});
    }
}

#pragma mark - MVRewardAdShowDelegate Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Show Reward Video Ad Success Delegate
- (void)onVideoAdShowSuccess:(NSString *)unitId
{
    [self log:[NSString stringWithFormat:@"unitId = %@, show success", unitId]];
    if (self.onVideoAdShowSuccess) {
        self.onVideoAdShowSuccess(@{@"unitId": unitId});
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Show Reward Video Ad Failed Delegate
- (void)onVideoAdShowFailed:(NSString *)unitId withError:(NSError *)error
{
    [self log:[NSString stringWithFormat:@"unitId = %@, show failed, error: %@", unitId, error]];
    if (self.onVideoAdShowFailed) {
        self.onVideoAdShowFailed(@{@"unitId": unitId, @"error": [error localizedDescription]});
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//About RewardInfo Delegate
- (void)onVideoAdDismissed:(NSString *)unitId withConverted:(BOOL)converted withRewardInfo:(MVRewardAdInfo *)rewardInfo
{
    if (rewardInfo) {
        [self log:[NSString stringWithFormat:@"unitId = %@, reward : name = %@, amount = %ld", unitId, rewardInfo.rewardName, (long)rewardInfo.rewardAmount]];
        if (self.onVideoAdDismissed) {
            self.onVideoAdDismissed(@{@"unitId": unitId, @"rewardName": rewardInfo.rewardName, @"rewardAmount": [NSNumber numberWithInteger:rewardInfo.rewardAmount]});
        }
    }
    else {
        [self log:[NSString stringWithFormat:@"unitId = %@, there is no reward to you", unitId]];
        if (self.onVideoAdDismissed) {
            self.onVideoAdDismissed(@{@"unitId": unitId});
        }
    }
}

- (void)onVideoAdClicked:(nullable NSString *)unitId{
    [self log:[NSString stringWithFormat:@"结果页被点击了"]];
    if (self.onVideoAdClicked) {
        self.onVideoAdClicked(@{@"unitId": unitId});
    }
}

#pragma mark - Utility

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
}

@end
