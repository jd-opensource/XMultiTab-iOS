//
//  NSArray+SSSSafe.h
//  Pods
//
//  Created by Corleone on 2021/1/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SSSSafe)
- (id)sss_safeObjectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
