#import "USRVInitializeStateError.h"
#import "USRVModuleConfiguration.h"
#import "USRVSDKMetrics.h"
#import "NSError+RequestDictionary.h"

@implementation USRVInitializeStateError : USRVInitializeState

- (instancetype)initWithConfiguration: (USRVConfiguration *)configuration erroredState: (id)erroredState code: (UADSErrorState)stateCode message: (NSString *)message {
    self = [super initWithConfiguration: configuration];

    if (self) {
        [self setErroredState: erroredState];
        [self setStateCode: stateCode];
        [self setMessage: message];
    }

    return self;
}

- (instancetype)execute {
    for (NSString *moduleName in [self.configuration getModuleConfigurationList]) {
        USRVModuleConfiguration *moduleConfiguration = [self.configuration getModuleConfiguration: moduleName];

        if (moduleConfiguration) {
            [moduleConfiguration initErrorState: self.configuration
                                           code: self.stateCode
                                        message: self.message];
        }
    }

    return NULL;
}

- (void)startWithCompletion:(void (^)(void))completion error:(void (^)(NSError * _Nonnull))error {
    for (NSString *moduleName in [self.configuration getModuleConfigurationList]) {
        USRVModuleConfiguration *moduleConfiguration = [self.configuration getModuleConfiguration: moduleName];

        if (moduleConfiguration) {
            [moduleConfiguration initErrorState: self.configuration
                                           code: self.stateCode
                                        message: self.message];
        }
    }
    
    NSError *finalError = [NSError errorWithFailureDictionary: @{
        @"code": @(self.stateCode),
        NSLocalizedDescriptionKey: self.message
    }];
    error(finalError);

}

@end
