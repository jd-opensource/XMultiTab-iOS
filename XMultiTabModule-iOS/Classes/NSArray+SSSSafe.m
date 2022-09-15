//
//  NSArray+SSSSafe.m
//  Pods
//
//  Created by Corleone on 2021/1/14.
//

#import "NSArray+SSSSafe.h"

@implementation NSArray (SSSSafe)

- (id)sss_safeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end
