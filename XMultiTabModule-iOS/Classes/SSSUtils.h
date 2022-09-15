//
//  SSSUtils.h
//  XMultiTabModule-iOS
//
//  Created by lixianke1 on 2022/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SCREEN_WIDTH                    CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT                   CGRectGetHeight([UIScreen mainScreen].bounds)
#define  kTabViewHeight              (49.0)
#define  kTabViewiPhoneXHeight       (83.0)

CG_INLINE BOOL
validateString(NSString *input) {
    if (!input) {
        return false;
    }
    if (![input isKindOfClass:[NSString class]]) {
        return false;
    }
    if (!input.length) {
        return false;
    }
    return true;
}

CG_INLINE BOOL
validateArray(NSArray *input) {
    if (!input) {
        return false;
    }
    if (![input isKindOfClass:[NSArray class]]) {
        return false;
    }
    if (!input.count) {
        return false;
    }
    return true;
}

CG_INLINE BOOL
validateDictionary(NSDictionary *input) {
    if (!input) {
        return false;
    }
    if (![input isKindOfClass:[NSDictionary class]]) {
        return false;
    }
    if (!input.count) {
        return false;
    }
    return true;
}

@interface SSSUtils : NSObject

+ (BOOL)hasNotch;
+ (UINavigationController *)emberInNaviWithRootVC:(UIViewController *)rootVC;

@end

NS_ASSUME_NONNULL_END
