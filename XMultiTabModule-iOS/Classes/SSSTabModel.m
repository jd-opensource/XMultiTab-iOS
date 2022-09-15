//
//  SSSTabModel.m
//  JDBrandSeckillModule
//
//  Created by lixianke1 on 2022/4/1.
//

#import "SSSTabModel.h"

NSString *const SSS_JD_URL = @"https://www.jd.com";

@implementation SSSTabConfigModel



@end

@implementation SSSTabItemModel


@end

@implementation SSSBaseTabWrapperModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"tabList" : @"SSSTabItemModel",
    };
}

+ (SSSBaseTabWrapperModel *)getDefaultTabModel {
    
    SSSTabItemModel *tabModel = [[SSSTabItemModel alloc] init];
    tabModel.tabType = 1;
    tabModel.link = SSS_JD_URL;
        
    SSSBaseTabWrapperModel *wrapperModel = [[SSSBaseTabWrapperModel alloc] init];
    wrapperModel.tabList = @[tabModel];
    
    return wrapperModel;
}

@end
