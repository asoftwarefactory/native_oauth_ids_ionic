#import "AppDelegate.h"
@import NativeOauthIds;

@interface AppDelegate (NativeOauthIds)

- (BOOL)application:(UIApplication *)application swizzledDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

+ (AppDelegate *_Nonnull) instance;

@end