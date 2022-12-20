#import <Cordova/CDV.h>

@interface NativeOauthIds : CDVPlugin <CieIdDelegate>

@property (nonatomic, strong) NSString *loginCallbackId;
@property (nonatomic, strong) CDVPluginResult *errorResult;

- (void)login:(CDVInvokedUrlCommand*)command;
- (void)onNotification:(NSNotification*)notification;
- (void)CieIDAuthenticationClosedWithSuccess;
- (void)CieIDAuthenticationCanceled;
- (void)CieIDAuthenticationClosedWithError:(NSString*)errorMessage;

@end