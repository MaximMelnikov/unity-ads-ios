#import <Foundation/Foundation.h>
#import "USRVWebRequestFactory.h"
#import "USRVSDKMetrics.h"

NS_ASSUME_NONNULL_BEGIN

@interface UADSWebRequestFactorySwiftAdapter : NSObject <IUSRVWebRequestFactory>
+ (instancetype)newWithMetricSender: (nullable id<ISDKMetrics>)metricSender andNetworkLayer: (id)networkLayer;
@end

NS_ASSUME_NONNULL_END
