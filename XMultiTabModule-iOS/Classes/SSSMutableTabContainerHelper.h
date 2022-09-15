//
//  SSSMutableTabContainerHelper.h
//  JDBrandSeckillModule
//
//  Created by 杨明 on 2022/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SSSMutableTabContainerEventNoDefine, // 未定义
    SSSMutableTabContainerEventSwitchTab, // 切换
    SSSMutableTabContainerEventHidenTabs, // 隐藏
} SSSMutableTabContainerEvent;

@interface SSSMutableTabContainerHelper : NSObject

+ (SSSMutableTabContainerEvent)fetchEvent:(NSString *)str;

+ (UIViewController *)createWebVC:(NSString *)url;


/// 创建通天塔导航VC (单独h5 使用)
/// @param url 网站链接
/// @param backBlock 返回事件
+ (UINavigationController *)createTTTNavWebVC:(NSString *)url
                              backBlock:(void (^)(void))backBlock;


@end

NS_ASSUME_NONNULL_END
