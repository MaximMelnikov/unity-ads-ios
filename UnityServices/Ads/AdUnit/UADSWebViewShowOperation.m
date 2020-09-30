#import "UADSWebViewShowOperation.h"
#import "UnityAdsDelegateUtil.h"
#import "USRVSDKMetrics.h"

static USRVConfiguration *configuration = nil;

@implementation UADSWebViewShowOperation

- (instancetype)initWithPlacementId:(NSString *)placementId parametersDictionary:(NSDictionary *)parametersDictionary {
    NSArray *params = @[placementId, parametersDictionary];
    if (configuration == nil) {
        configuration = [[USRVConfiguration alloc] init];
        USRVLogError(@"Configuration is null, apply default configuration");
    }
    self = [super initWithMethod:@"show" webViewClass:@"webview" parameters:params waitTime:configuration.showTimeout / 1000];
    return self;
}

- (void)main {
    [super main];

    if (!self.success) {
        NSString *placementId = [self.parameters objectAtIndex:0];
        USRVLogError(@"Unity Ads webapp timeout, shutting down Unity Ads");
        [UnityAdsDelegateUtil unityAdsDidError:kUnityAdsErrorShowError withMessage:@"Webapp timeout, shutting down Unity Ads"];
        [UnityAdsDelegateUtil unityAdsDidFinish:placementId withFinishState:kUnityAdsFinishStateError];
        [[USRVSDKMetrics getInstance] sendEvent:@"native_show_callback_failed"];
    }
    else {
        USRVLogDebug(@"SHOW SUCCESS");
    }
}

+ (void)callback:(NSArray *)params {
    if ([[params objectAtIndex:0] isEqualToString:@"OK"]) {
        [super callback:params];
    }
}

+ (void)setConfiguration:(USRVConfiguration *)config {
    configuration = config;
}

@end
