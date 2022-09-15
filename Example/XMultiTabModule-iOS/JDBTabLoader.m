//
//  JDBTabLoader.m
//  JDBMultiTabModule_Example
//
//  Created by lixianke1 on 2022/8/26.
//  Copyright © 2022 lixianke1. All rights reserved.
//

#import "JDBTabLoader.h"
#import "JDBViewController.h"
#import <MJExtension/MJExtension.h>

@implementation JDBTabLoader

+ (instancetype)sharedLoader {
    static JDBTabLoader *loader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[JDBTabLoader alloc] init];
    });
    
    return loader;
}

- (UIViewController *)loadNativeWithModule:(NSString *)module params:(NSString *)params {
    NSDictionary *paramsDict = [params mj_JSONObject];
    return [[JDBViewController alloc] initWithTitle:[paramsDict objectForKey:@"title"]];
}

@end
