
#import "RNReactNativeMobvista.h"

@implementation RNReactNativeMobvista

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

- (NSString*) test
{
    return @"test";
}

- (NSDictionary *)constantsToExport
{
    
    return @{
             @"test": self.test
             };
}

- (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
