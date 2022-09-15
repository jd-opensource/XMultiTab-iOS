//
//  SSSMutableTabContainerHelper.m
//  JDBrandSeckillModule
//
//  Created by 杨明 on 2022/2/10.
//

#import "SSSMutableTabContainerHelper.h"
#import "SSSUtils.h"
#import <SafariServices/SafariServices.h>

@implementation SSSMutableTabContainerHelper

#pragma mark - Class Method

+ (SSSMutableTabContainerEvent)fetchEvent:(NSString *)str{
    if ([@"switchTab" isEqualToString:str]) {
        return SSSMutableTabContainerEventSwitchTab;
    }else if ([@"hidenTabs" isEqualToString:str]) {
        return SSSMutableTabContainerEventHidenTabs;
    }else {
        return SSSMutableTabContainerEventNoDefine;
    }
}


+ (UIViewController *)createWebVC:(NSString *)url{
    
    if (!validateString(url)) {
        url = @"https://www.jd.com";
    }
    NSURL *link = [NSURL URLWithString:url];
    
    // 通天塔容器
    UIViewController *webVC  = [[SFSafariViewController alloc] initWithURL:link];
    
    return webVC;
}

+ (UINavigationController *)createTTTNavWebVC:(NSString *)url
                           backBlock:(void (^)(void))backBlock {
    
    if (!validateString(url)) {
        url = @"https://www.jd.com";
    }
    
    UIViewController *webVC  = [self createWebVC:url];
    
    return [SSSUtils emberInNaviWithRootVC:webVC];
}



@end
