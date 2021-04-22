//
//  eeuiJpushDelegate.h
//  eeuiJpush
//
//  Created by Hitosea-005 on 2021/4/19.
//

#import <Foundation/Foundation.h>
#import <JPUSHService.h>

NS_ASSUME_NONNULL_BEGIN

@interface eeuiJpushDelegate : NSObject<JPUSHRegisterDelegate>
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
