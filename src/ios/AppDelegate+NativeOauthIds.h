#import "AppDelegate.h"

@interface AppDelegate (NativeOauthIds)

- (BOOL)application:(UIApplication *_Nullable)application swizzledDidFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions;

- (BOOL)application:(UIApplication *_Nullable)app openURL:(NSURL *_Nullable)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *_Nullable)options;

+ (AppDelegate *_Nonnull) instance;

@end
