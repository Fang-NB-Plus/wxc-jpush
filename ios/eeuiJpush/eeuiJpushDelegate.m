//
//  eeuiJpushDelegate.m
//  eeuiJpush
//
//  Created by Hitosea-005 on 2021/4/19.
//

#import "eeuiJpushDelegate.h"
#import <eeuiNewPageManager.h>
#import <UserNotifications/UserNotifications.h>

@implementation eeuiJpushDelegate

+(instancetype)shareInstance{
    
    static eeuiJpushDelegate *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[eeuiJpushDelegate alloc] init];
    });
    
    return instance;
}

#pragma mark - JPUSHRegisterDelegate

//iOS 12 support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler{
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSDictionary * sendDic = @{
        @"type":@"notification",
        @"data":userInfo
    };
    
    [[eeuiNewPageManager sharedIntstance] postMessage:sendDic];
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}
/*
 * @brief handle UserNotifications.framework [didReceiveNotificationResponse:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param response 通知响应对象
 * @param completionHandler
 */
//iOS 10 support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSDictionary * sendDic = @{
        @"type":@"notification",
        @"data":userInfo
    };
    
    [[eeuiNewPageManager sharedIntstance] postMessage:sendDic];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

/*
 * @brief handle UserNotifications.framework [openSettingsForNotification:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 当前管理的通知对象
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSDictionary * sendDic = @{
        @"type":@"notification",
        @"data":userInfo
    };
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
        [[eeuiNewPageManager sharedIntstance] postMessage:sendDic];
    }else{
        
        [[eeuiNewPageManager sharedIntstance] postMessage:sendDic];
    }
}

/**
 * 监测通知授权状态返回的结果
 * @param status 授权通知状态，详见JPAuthorizationStatus
 * @param info 更多信息，预留参数
 */
- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info{
    
}



@end
