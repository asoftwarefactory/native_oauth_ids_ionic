#import "AppDelegate+NativeOauthIds-Swift.h"

@implementation AppDelegate (NativeOauthIds)

    static AppDelegate* instance;
    + (AppDelegate*) instance {
        return instance;
    }

    - (BOOL)application:(UIApplication *)application swizzledDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        [self application:application swizzledDidFinishLaunchingWithOptions:launchOptions];
        instance = self;
    }

    - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
        NSString *urlString = [url absoluteString];
        if ([urlString rangeOfString:@"https://"].location != NSNotFound) {
            NSInteger startPos = [urlString rangeOfString:@"https://"].location;
            urlString = [urlString substringFromIndex:startPos];

            NSDictionary *response = @{ @"payload": urlString };
            NSString *notificationName = @"RETURN_FROM_CIEID";
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:response];
            return YES;
        }
        return YES;
    }

@end




