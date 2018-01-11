//
//  RNNativeAdView.m
//  RNReactNativeMobvista
//
//  Created by Phạm Xuân Duy on 12/27/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNNativeAdView.h"
#import <MVSDK/MVMediaView.h>
#import <MVSDK/MVCampaign.h>

#define KNativeUnitID @"30145"
//#define KRewardVideo @"30146"
#define KPlacementID @""

@implementation RNNativeAdView {
    UIView *_nativeAdView;
    NSString *_text;
    CGFloat _width;
    CGFloat _height;
    MVNativeAdManager *_nativeVideoAdManager;
    BOOL _isVideo;
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
//    [self initNativeAd];
//    [self initNativeVideoAd];
    
    [self initNativeVideoAdManager];
    [self preLoadAds];
    [self loadAds];
    
    
}

- (void)initNativeAd:(MVCampaign *)campaign {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 10;
    
    _nativeAdView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, width, 65 + (width - 20) / 1200 * 627)];
    _nativeAdView.backgroundColor = [UIColor whiteColor];

    // icon image ad
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    imageHolder.layer.cornerRadius = 4;
    imageHolder.layer.masksToBounds = YES;
    [campaign loadIconUrlAsyncWithBlock:^(UIImage *image) {
        if (image) {
            [imageHolder setImage:image];
        }
    }];
    [_nativeAdView addSubview:imageHolder];
    
    // app name
    UILabel *appNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, width - 75, 18)];
    appNameLabel.text = campaign.appName;
    appNameLabel.numberOfLines = 1;
    appNameLabel.font = [UIFont systemFontOfSize:15];
    appNameLabel.clipsToBounds = YES;
    appNameLabel.backgroundColor = [UIColor clearColor];
    [_nativeAdView addSubview:appNameLabel];
    
    // app desc
    UILabel *appDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 26, width - 75, 27)];
    appDescLabel.text = campaign.appDesc;
    appDescLabel.numberOfLines = 2;
    appDescLabel.font = [UIFont systemFontOfSize:11];
    appDescLabel.clipsToBounds = YES;
    appDescLabel.backgroundColor = [UIColor clearColor];
    [_nativeAdView addSubview:appDescLabel];
    
    // big image ad
    UIImageView *bigImageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, width - 20, (width - 20) / 1200 * 627)];
    bigImageHolder.layer.masksToBounds = YES;
    [campaign loadImageUrlAsyncWithBlock:^(UIImage *image) {
        if (image) {
            [bigImageHolder setImage:image];
        }
    }];
    [_nativeAdView addSubview:bigImageHolder];
    
    [self addSubview:_nativeAdView];
    
//    [self.nativeVideoAdManager registerViewForInteraction:bigImageHolder withCampaign:campaign];
    [self.nativeVideoAdManager registerViewForInteraction:self withCampaign:campaign];
}

- (void)initNativeVideoAd:(MVCampaign*)campaign unitId:(NSString *)unitId {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 10;
    CGFloat heightMvMediaView = (width - 20) / 16 * 9;
    
    _nativeAdView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, width, heightMvMediaView + 140)];
    _nativeAdView.backgroundColor = [UIColor whiteColor];
    
    // mv media view
    MVMediaView *mvMediaView = [[MVMediaView alloc] initWithFrame:CGRectMake(10, 10, width - 20, heightMvMediaView)];
    [mvMediaView setMediaSourceWithCampaign:campaign unitId:unitId];
    mvMediaView.autoLoopPlay = NO;
    mvMediaView.videoRefresh = YES;
    mvMediaView.allowFullscreen = YES;
    mvMediaView.delegate = self;
    [_nativeAdView addSubview:mvMediaView];
    
    // icon image view
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(10, heightMvMediaView + 20, 60, 60)];
    imageHolder.layer.cornerRadius = 4;
    imageHolder.layer.masksToBounds = YES;
    
    imageHolder.backgroundColor = [UIColor redColor];
    [campaign loadIconUrlAsyncWithBlock:^(UIImage *image) {
        if (image) {
            [imageHolder setImage:image];
        }
    }];
    [_nativeAdView addSubview:imageHolder];
    
    // app name
    UILabel *appNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, heightMvMediaView + 20, width - 90, 25)];
    appNameLabel.text = campaign.appName;
    appNameLabel.numberOfLines = 1;
    appNameLabel.font = [UIFont systemFontOfSize:22];
    appNameLabel.clipsToBounds = YES;
    appNameLabel.backgroundColor = [UIColor clearColor];
    [_nativeAdView addSubview:appNameLabel];
    
    // app desc
    UILabel *appDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, heightMvMediaView + 50, width - 90, 40)];
    appDescLabel.text = campaign.appDesc;
    appDescLabel.numberOfLines = 2;
    appDescLabel.font = [UIFont systemFontOfSize:15];
    appDescLabel.clipsToBounds = YES;
    appDescLabel.backgroundColor = [UIColor clearColor];
    [_nativeAdView addSubview:appDescLabel];
    
    // add call btn
    UIButton *adCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addCallBtn addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside]; 1CB0F6
    [adCallBtn setTitle:campaign.adCall forState:UIControlStateNormal];
    adCallBtn.frame = CGRectMake(30, heightMvMediaView + 95, width - 60, 35);
    adCallBtn.backgroundColor = [UIColor colorWithRed:28.0 / 255.0 green:176.0 / 255.0 blue:246.0 / 255.0 alpha:1.0];
    adCallBtn.layer.cornerRadius = 6;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.1];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.5;
    [adCallBtn.titleLabel.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [adCallBtn.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    [_nativeAdView addSubview:adCallBtn];
    [self.nativeVideoAdManager registerViewForInteraction:adCallBtn withCampaign:campaign];
    
    [self addSubview:_nativeAdView];
}

- (void)initPetNativeVideoAd:(MVCampaign*)campaign unitId:(NSString*)unitId {
    CGFloat margin = 35 / 3;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - margin * 2;
    CGFloat radius = 40 / 3;
    CGFloat widthMvMediaView = width - 20;
    CGFloat heightMvMediaView = widthMvMediaView / 16 * 9;
    
//    _nativeAdView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, width, heightMvMediaView + 140)];
    _nativeAdView = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, width, heightMvMediaView + 65)];
    _nativeAdView.backgroundColor = [UIColor whiteColor];
    _nativeAdView.layer.cornerRadius = radius;
    
    // icon heart
    UIImageView *iconHeart = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 22, 19)];
    UIImage *image = [UIImage imageNamed:@"heart"];
    iconHeart.image = image;
    [_nativeAdView addSubview:iconHeart];
    
    // icon text
    UILabel *iconText = [[UILabel alloc]initWithFrame:CGRectMake(15, 29, 22, 13)];
    iconText.text = @"推荐";
    iconText.numberOfLines = 1;
    iconText.font = [UIFont systemFontOfSize:10];
    iconText.clipsToBounds = YES;
    iconText.backgroundColor = [UIColor clearColor];
    iconText.textAlignment = UITextAlignmentCenter;
    iconText.textColor = [UIColor colorWithRed:253.0 / 255.0 green:66.0 / 255.0 blue:66.0 / 255.0 alpha:1.0];
    [_nativeAdView addSubview:iconText];
    
    // icon image view
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(42, 10, 32, 32)];
    imageHolder.layer.cornerRadius = 5;
    imageHolder.layer.borderWidth = 2;
    imageHolder.layer.borderColor = [UIColor colorWithRed:57.0 / 255.0 green:185.0 / 255.0 blue:138.0 / 255.0 alpha:1.0].CGColor;
    imageHolder.layer.masksToBounds = YES;
    
    imageHolder.backgroundColor = [UIColor redColor];
    [campaign loadIconUrlAsyncWithBlock:^(UIImage *image) {
        if (image) {
            [imageHolder setImage:image];
        }
    }];
    [_nativeAdView addSubview:imageHolder];
    
    // app name
    UILabel *appNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, width - 190, 21)];
    appNameLabel.text = campaign.appName;
    appNameLabel.numberOfLines = 1;
    appNameLabel.font = [UIFont systemFontOfSize:16];
    appNameLabel.clipsToBounds = YES;
    appNameLabel.backgroundColor = [UIColor clearColor];
    appNameLabel.textColor = [UIColor colorWithRed:57.0 / 255.0 green:185.0 / 255.0 blue:138.0 / 255.0 alpha:1.0];
    [_nativeAdView addSubview:appNameLabel];
    
    // app desc
    UILabel *appDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 31, width - 190, 18)];
    appDescLabel.text = campaign.appDesc;
    appDescLabel.numberOfLines = 2;
    appDescLabel.font = [UIFont systemFontOfSize:13];
    appDescLabel.clipsToBounds = YES;
    appDescLabel.backgroundColor = [UIColor clearColor];
    appDescLabel.textColor = [UIColor colorWithRed:97.0 / 255.0 green:97.0 / 255.0 blue:100.0 / 255.0 alpha:1.0];
    [_nativeAdView addSubview:appDescLabel];
    
    // add call btn
    UIButton *adCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [addCallBtn addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside]; 1CB0F6
    [adCallBtn setTitle:campaign.adCall forState:UIControlStateNormal];
    adCallBtn.frame = CGRectMake(width - 80, 15, 71, 27);
    adCallBtn.backgroundColor = [UIColor colorWithRed:12.0 / 255.0 green:194.0 / 255.0 blue:135.0 / 255.0 alpha:1.0];
    adCallBtn.layer.cornerRadius = 13;
    [_nativeAdView addSubview:adCallBtn];
    [self.nativeVideoAdManager registerViewForInteraction:adCallBtn withCampaign:campaign];
    
    // mv media view
    MVMediaView *mvMediaView = [[MVMediaView alloc] initWithFrame:CGRectMake(10, 50, widthMvMediaView, heightMvMediaView)];
    [mvMediaView setMediaSourceWithCampaign:campaign unitId:unitId];
    mvMediaView.autoLoopPlay = NO;
    mvMediaView.videoRefresh = YES;
    mvMediaView.allowFullscreen = YES;
    mvMediaView.delegate = self;
    mvMediaView.layer.cornerRadius = 10;
    [_nativeAdView addSubview:mvMediaView];
    
    [self addSubview:_nativeAdView];
}

- (void)initNativeVideoAdManager {
    [self nativeVideoAdManager];
}

- (void)preLoadAds {
    [[MVSDK sharedInstance] preloadNativeAdsWithUnitId:KNativeUnitID fbPlacementId:KPlacementID videoSupport:YES forNumAdsRequested:1];
}

- (void)loadAds {
    [self.nativeVideoAdManager loadAds];
}

- (MVNativeAdManager *)nativeVideoAdManager
{
    //If the native ad manager is not existed, init it now.
    if (_nativeVideoAdManager == nil) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIViewController *rootViewController = [keyWindow rootViewController];
        _nativeVideoAdManager = [[MVNativeAdManager alloc] initWithUnitID:KNativeUnitID fbPlacementId:KPlacementID supportedTemplates:@[[MVTemplate templateWithType:MVAD_TEMPLATE_BIG_IMAGE adsNum:1]] autoCacheImage:NO adCategory:0 presentingViewController:rootViewController];
        _nativeVideoAdManager.showLoadingView = YES;
        _nativeVideoAdManager.delegate = self;
    }
    return _nativeVideoAdManager;
}

- (void)layoutSubviews {
    NSLog(@"layout subviews");
}

- (void)setText:(NSString*) text {
    _text = text;
}

- (void)setWidth:(CGFloat) width {
    _width = width;
}

- (void)setHeight:(CGFloat) height {
    _height = height;
}

- (void)setIsVideo:(BOOL)isVideo {
    _isVideo = isVideo;
}

- (void)loadNativeAd {
//    _nativeAdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
//    _nativeAdView.backgroundColor = [UIColor redColor];
//    [self addSubview:_nativeAdView];
}

#pragma mark AdManger delegate
- (void)nativeAdsLoaded:(NSArray *)nativeAds nativeManager:(nonnull MVNativeAdManager *)nativeManager
{
    
    if (nativeAds.count > 0) {
        [self log:[NSString stringWithFormat:@"unitid = %@,%lu ads loaded", nativeManager.currentUnitId,(unsigned long)[nativeAds count]]];
        MVCampaign *mvCampaign = nativeAds[0];
        
        if (_nativeAdView == nil) {
            if (_isVideo) {
//                [self initNativeVideoAd: mvCampaign unitId:KNativeUnitID];
                [self initPetNativeVideoAd:mvCampaign unitId:KNativeUnitID];
            } else {
                [self initNativeAd: mvCampaign];
            }
        }
        if (self.onNativeAdsLoaded) {
            self.onNativeAdsLoaded(@{@"unitId": nativeManager.currentUnitId});
        }
    }
    else {
        [self log:@"no ads"];
        if (self.onNativeAdsLoaded) {
            self.onNativeAdsLoaded(@{});
        }
    }
}

- (void)nativeAdsFailedToLoadWithError:(NSError *)error nativeManager:(nonnull MVNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"unitid = %@,Failed to load ads, error:%@",nativeManager.currentUnitId, error.domain]];
    if (self.onNativeAdsFailedToLoadWithError) {
        self.onNativeAdsFailedToLoadWithError(@{@"unitId": nativeManager.currentUnitId, @"error": error.domain});
    }
}



#pragma mark MediaView delegate
- (void)MVMediaViewWillEnterFullscreen:(MVMediaView *)mediaView{
    [self log:@"MVMedia View Will Enter Full Screen"];
    if (self.onMVMediaViewWillEnterFullscreen) {
        self.onMVMediaViewWillEnterFullscreen(@{});
    }
}


- (void)MVMediaViewDidExitFullscreen:(MVMediaView *)mediaView{
    [self log:@"MVMedia View Did Exit Full Screen"];
    if (self.onMVMediaViewDidExitFullscreen) {
        self.onMVMediaViewDidExitFullscreen(@{});
    }
}


#pragma mark MediaView and AdManger Click delegate

- (void)nativeAdDidClick:(MVCampaign *)nativeAd nativeManager:(nonnull MVNativeAdManager *)nativeManager
{
    [self log:@"Registerview Ad is clicked"];
    if (self.onNativeAdDidClick) {
        self.onNativeAdDidClick(@{});
    }
}
- (void)nativeAdDidClick:(MVCampaign *)nativeAd mediaView:(nonnull MVMediaView *)mediaView
{
    [self log:@"MVMediaView Ad is clicked"];
    if (self.onNativeVideoAdDidClick) {
        self.onNativeVideoAdDidClick(@{});
    }
}

- (void)nativeAdClickUrlWillStartToJump:(NSURL *)clickUrl nativeManager:(nonnull MVNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"Registerview click url:%@", clickUrl.absoluteString]];
    if (self.onNativeAdClickUrlWillStartToJump) {
        self.onNativeAdClickUrlWillStartToJump(@{@"clickUrl": clickUrl.absoluteString});
    }
}
- (void)nativeAdClickUrlWillStartToJump:(NSURL *)clickUrl mediaView:(nonnull MVMediaView *)mediaView
{
    [self log:[NSString stringWithFormat:@"MVMediaView click url:%@", clickUrl.absoluteString]];
    if (self.onNativeVideoAdClickUrlWillStartToJump) {
        self.onNativeVideoAdClickUrlWillStartToJump(@{@"clickUrl": clickUrl.absoluteString});
    }
}

- (void)nativeAdClickUrlDidJumpToUrl:(NSURL *)jumpUrl nativeManager:(nonnull MVNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"Registerview jump to url:%@", jumpUrl.absoluteString]];
    if (self.onNativeAdClickUrlDidJumpToUrl) {
        self.onNativeAdClickUrlDidJumpToUrl(@{@"jumpUrl": jumpUrl.absoluteString});
    }
}
- (void)nativeAdClickUrlDidJumpToUrl:(NSURL *)jumpUrl mediaView:(nonnull MVMediaView *)mediaView
{
    [self log:[NSString stringWithFormat:@"MVMediaView jump to url:%@", jumpUrl.absoluteString]];
    if (self.onNativeVideoAdClickUrlDidJumpToUrl) {
        self.onNativeVideoAdClickUrlDidJumpToUrl(@{@"jumpUrl": jumpUrl.absoluteString});
    }
}

- (void)nativeAdClickUrlDidEndJump:(NSURL *)finalUrl error:(NSError *)error nativeManager:(nonnull MVNativeAdManager *)nativeManager
{
    [self log:[NSString stringWithFormat:@"Registerview final url:%@ error:%@", finalUrl.absoluteString, error?error.domain:@"none"]];
    if (self.onNativeAdClickUrlDidEndJump) {
        self.onNativeAdClickUrlDidEndJump(@{@"finalUrl":finalUrl.absoluteString, @"error": error ? error.domain : @"none"});
    }
}
- (void)nativeAdClickUrlDidEndJump:(NSURL *)finalUrl error:(NSError *)error mediaView:(nonnull MVMediaView *)mediaView
{
    [self log:[NSString stringWithFormat:@"MVMediaView final url:%@ error:%@", finalUrl.absoluteString, error?error.domain:@"none"]];
    if (self.onNativeVideoAdClickUrlDidEndJump) {
        self.onNativeVideoAdClickUrlDidEndJump(@{@"finalUrl":finalUrl.absoluteString, @"error": error ? error.domain : @"none"});
    }
}

- (void)log:(NSString *)logString
{
    NSLog(@"%@", logString);
}

@end
