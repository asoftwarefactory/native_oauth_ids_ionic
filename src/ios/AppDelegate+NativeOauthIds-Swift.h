#import "AppDelegate.h"
#import "NativeOauthIds-Swift.h"

@interface AppDelegate (NativeOauthIds)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

+ (AppDelegate *_Nonnull) instance;

@end







