//
//  SSSUtils.m
//  XMultiTabModule-iOS
//
//  Created by lixianke1 on 2022/8/23.
//

#import "SSSUtils.h"
#import <UIKit/UIKit.h>

@implementation SSSUtils

+(BOOL)hasNotch {
    if (@available(iOS 11.0, *)) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *window in windows) {
            if (window.isKeyWindow) {
                if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
                    return window.safeAreaInsets.top >= 44;
                } else {
                    return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0;
                }
            }
        }
    }
    return false;
}

+ (UINavigationController *)emberInNaviWithRootVC:(UIViewController *)rootVC {
    if (!rootVC || ![rootVC isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    UINavigationController *nav = [[UINavigationController alloc] init];
    nav.view.backgroundColor = [UIColor whiteColor];
    nav.viewControllers = @[rootVC];
    return nav;
}

@end


