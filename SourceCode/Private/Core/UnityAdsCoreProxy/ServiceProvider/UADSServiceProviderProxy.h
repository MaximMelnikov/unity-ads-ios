#import "UADSProxyReflection.h"
#import "UADSCommonNetworkProxy.h"
#import "UADSSDKInitializerProxy.h"
#import "USRVInitializeStateFactory.h"
#import "UADSDeviceInfoProvider.h"
NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary  * _Nonnull  (^UADSInfoGetter)(bool);

@protocol UADSNativeNetworkLayerProvider <NSObject>
- (UADSCommonNetworkProxy *)nativeNetworkLayer;
@end

@interface UADSServiceProviderProxy : UADSProxyReflection
+ (UADSServiceProviderProxy *)newWithDeviceInfoProvider:(id)deviceInfoProvider;
- (UADSCommonNetworkProxy *)  nativeNetworkLayer;
- (UADSCommonNetworkProxy *)  nativeMetricsNetworkLayer;
- (void)                      saveConfiguration: (NSDictionary *)configDictionary;
- (UADSSDKInitializerProxy *)sdkInitializerWithFactory: (USRVInitializeStateFactory *)factory;
@end

NS_ASSUME_NONNULL_END
