//
//  JDBTabLoader.h
//  JDBMultiTabModule_Example
//
//  Created by lixianke1 on 2022/8/26.
//  Copyright © 2022 lixianke1. All rights reserved.
//

#import <Foundation/Foundation.h>
@import XMultiTabModule_iOS;

NS_ASSUME_NONNULL_BEGIN

@interface JDBTabLoader : NSObject <SSSMultiTabDelagate>

+ (instancetype)sharedLoader;

@end

NS_ASSUME_NONNULL_END
