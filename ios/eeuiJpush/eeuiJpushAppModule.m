//
//  eeuiJpushAppModule.m
//  Pods
//

#import "eeuiJpushAppModule.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
#import <JPUSHService.h>

@interface eeuiJpushAppModule ()

@end

@implementation eeuiJpushAppModule

@synthesize weexInstance;

WX_PlUGIN_EXPORT_MODULE(eeuiJpush, eeuiJpushAppModule)
WX_EXPORT_METHOD(@selector(setTags:callback:))
WX_EXPORT_METHOD(@selector(getAllTags:))
WX_EXPORT_METHOD(@selector(deleteTags:callback:))
WX_EXPORT_METHOD(@selector(clearTags:))

WX_EXPORT_METHOD(@selector(setAlias:callback:))
WX_EXPORT_METHOD(@selector(getAlias:))
WX_EXPORT_METHOD(@selector(deleteAlias:callback:))

-(void)setTags:(NSString *)tag callback:(WXModuleKeepAliveCallback)callback{
    NSSet *set = [NSSet setWithObject:tag];
    [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        if (iResCode == 0) {
            callback(@YES,NO);
        }else
            callback(@NO,NO);
        
    } seq:100];
}

-(void)getAllTags:(WXModuleKeepAliveCallback)callback{
    [JPUSHService getAllTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        if (iResCode == 0) {
            NSArray *tagArray = iTags.allObjects;
            callback(tagArray,NO);
        }else
            callback(@[],NO);
    } seq:103];
}

- (void)deleteTags:(NSString *)tag callback:(WXModuleKeepAliveCallback)callback{
    [JPUSHService deleteTags:[NSSet setWithObject:tag] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        if (iResCode == 0) {
            callback(@YES,NO);
        }
            callback(@NO,NO);
    } seq:100];
}

- (void)clearTags:(WXModuleKeepAliveCallback)callback{
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        if (iResCode == 0) {
            callback(@YES,NO);
        }
            callback(@NO,NO);
    } seq:100];
    
}

-(void)setAlias:(NSString *)alias callback:(WXModuleKeepAliveCallback)callback{
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            callback(@YES,NO);
        }
            callback(@NO,NO);
    } seq:103];
}

-(void)getAlias:(WXModuleKeepAliveCallback)callback{
    [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            callback(iAlias,NO);
        }else
            callback(@"",NO);
    } seq:104];
}

- (void)deleteAlias:(NSString *)tag callback:(WXModuleKeepAliveCallback)callback{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            callback(@YES,NO);
        }
            callback(@NO,NO);
    } seq:105];
}

@end
