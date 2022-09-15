//
//  SSSTabModel.h
//  JDBrandSeckillModule
//
//  Created by lixianke1 on 2022/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const SSS_JD_URL;

typedef NS_ENUM(NSUInteger, SSSTabType) {
    SSSTabTypeWeb, // H5容器
    SSSTabTypeNative, // 原生容器
};

@interface SSSTabConfigModel : NSObject

@property (nonatomic, assign) NSInteger   selectIndex;         // 底部导航选中位置
@property (nonatomic, copy) NSString      *tabBackground;      // tab背景图

@end

@interface SSSTabItemModel : NSObject

@property (nonatomic, assign) NSInteger          specialType;    // 是否是异形Tab，1 是，默认0非异形
@property (nonatomic, assign) SSSTabType         tabType;        // tab类型
@property (nonatomic, copy)   NSString           *tabName;       // tab描述
@property (nonatomic, copy)   NSString           *tabImage;      // tab非选中背景图片
@property (nonatomic, copy)   NSString           *selectTabImage;// tab选中背景图片
@property (nonatomic, copy)   NSString           *module;        // 路由
@property (nonatomic, copy)   NSString           *params;        // 传递原生容器参数，有多少传递多少
@property (nonatomic, copy)   NSString           *link;          // H5链接

@end

@interface SSSBaseTabWrapperModel : NSObject

@property(nonatomic,   copy) NSString                       *code;
@property(nonatomic, strong) NSArray<SSSTabItemModel *>     *tabList;
@property(nonatomic, strong) SSSTabConfigModel              *tabConfig;

+ (SSSBaseTabWrapperModel *)getDefaultTabModel; // 兜底数据

@end

NS_ASSUME_NONNULL_END
