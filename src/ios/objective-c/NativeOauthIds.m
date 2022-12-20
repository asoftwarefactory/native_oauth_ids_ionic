#import "NativeOauthIds.h"

@implementation NativeOauthIds

- (void)login:(CDVInvokedUrlCommand*)command {
  self.loginCallbackId = command.callbackId;
  NSString *url = [command.arguments objectAtIndex:0];
  if (![url isEqualToString:@""]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotification:) name:IDNotificationManager.NOTIFICATION_CENTER_NAME object:nil];
    CieIDWKWebViewController *cieIDAuthenticator = [[CieIDWKWebViewController alloc] init];
    cieIDAuthenticator.modalPresentationStyle = UIModalPresentationFullScreen;
    cieIDAuthenticator.delegate = self;
    cieIDAuthenticator.path = url;
    [self.viewController presentViewController:cieIDAuthenticator animated:YES completion:nil];
  } else {
    [self.commandDelegate sendPluginResult:self.errorResult callbackId:command.callbackId];
  }
}

- (void)onNotification:(NSNotification*)notification {
  NSDictionary *dict = notification.userInfo;
  if (dict[@"code"] != nil && dict[@"session_state"] != nil) {
    NSString *code = dict[@"code"];
    NSString *session_state = dict[@"session_state"];
    NSString *msg = [NSString stringWithFormat:@"code=%@&session_state=%@", code, session_state];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.loginCallbackId];
  }
}

- (void)CieIDAuthenticationClosedWithSuccess {

}

- (void)CieIDAuthenticationCanceled {

}

- (void)CieIDAuthenticationClosedWithError:(NSString*)errorMessage {

}

@end