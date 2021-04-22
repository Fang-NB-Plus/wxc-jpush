//
//  eeuiJpushEntry.m
//  Pods
//

#import "eeuiJpushEntry.h"
#import "eeuiJpushWebModule.h"
#import "WeexInitManager.h"
#import <WebKit/WKWebView.h>
#import <JPUSHService.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "Config.h"
#import <eeuiNewPageManager.h>
#import "eeuiJpushDelegate.h"

@interface eeuiJpushEntry ()

@end

WEEX_PLUGIN_INIT(eeuiJpushEntry)
@implementation eeuiJpushEntry

//启动成功
- (void) didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:[eeuiJpushDelegate shareInstance]];
    
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    
    
    /*
     __block NSString *advertisingId;
     if (@available(iOS 14, *)) {
     [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
     if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
     advertisingId = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
     }
     }];
     } else {
     // 使用原方式访问 IDFA
     advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
     }
     */
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    NSDictionary *getuiConfig = [Config getObject:@"jpush"];
    NSString *appId = [NSString stringWithFormat:@"%@", getuiConfig[@"JPUSH_APP_ID"]];
    
    [JPUSHService setupWithOption:launchOptions appKey:appId
                          channel:nil
                   apsForProduction:NO];
    
      
}

//注册推送成功调用
- (void) didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

// 注册推送失败调用
- (void) didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

//iOS10以下使用这两个方法接收通知
- (void) didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//iOS10新增：处理前台收到通知的代理方法
- (void) willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0))
{
    
}

//iOS10新增：处理后台点击通知的代理方法
- (void) didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0))
{
    
}

//捕捉回调
- (void) openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
}

//捕捉握手
- (void) handleOpenURL:(NSURL *)url
{

}

//webView初始化
- (void) setJSCallModule:(JSCallCommon *)callCommon webView:(WKWebView*)webView
{
    [callCommon setJSCallAssign:webView name:@"eeuiJpush" bridge:[[eeuiJpushWebModule alloc] init]];
}


@end
