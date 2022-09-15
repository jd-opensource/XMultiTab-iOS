//
//  JDBAppDelegate.m
//  XMultiTabModule-iOS
//
//  Created by lixianke1 on 08/23/2022.
//  Copyright (c) 2022 lixianke1. All rights reserved.
//

#import "JDBAppDelegate.h"
#import "JDBTabLoader.h"
@import XMultiTabModule_iOS;
#import <MJExtension/MJExtension.h>

@implementation JDBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *localData = [self fetchLocalData];
    SSSBaseTabWrapperModel *model = [SSSBaseTabWrapperModel mj_objectWithKeyValues:localData];
    SSSMultiTabController* tabVC = [[SSSMultiTabController alloc] init];
    tabVC.delegate = [JDBTabLoader sharedLoader];
    dispatch_after(DISPATCH_TIME_NOW + 0.1, dispatch_get_main_queue(), ^{
        [tabVC refreshWithTabModel:model];
    });
    [[UIApplication sharedApplication].windows firstObject].rootViewController = tabVC;
    [[[UIApplication sharedApplication].windows firstObject] makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (NSDictionary *)fetchLocalData {
    NSDictionary *res = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tabs" ofType:@"json"];
    if ([self isFileExsit:filePath]) {
        @try {
            NSData *binData = [NSData dataWithContentsOfFile:filePath];
            if (binData) {
                NSError *readError = nil;
                res = [NSJSONSerialization JSONObjectWithData:binData
                                                          options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers
                                                            error:&readError];
                if (!readError && res) {
                    if (!validateDictionary(res)) {
                        res = nil;
                    }
                }
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }

    }
    return res;
}

- (BOOL)isFileExsit:(NSString *)path {
    if (!validateString(path)) {
        return NO;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

@end
