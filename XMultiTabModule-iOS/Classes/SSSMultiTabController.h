//
//  SSSMultiTabController.h
//  JDBrandSeckillModule
//
//  Created by 杨明 on 2022/3/28.
//

#import <UIKit/UIKit.h>
#import "SSSTabModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol SSSMultiTabDelagate <NSObject>

@optional
- (UIViewController *)loadWebWithURL:(NSString *)url;
- (UIViewController *)loadNativeWithModule:(NSString *)module params:(NSString *)params;

@end

@interface SSSMultiTabController : UIViewController

- (void)refreshWithTabModel:(SSSBaseTabWrapperModel *)tabModel;
@property (nonatomic, weak) id<SSSMultiTabDelagate> delegate;

@end

NS_ASSUME_NONNULL_END
