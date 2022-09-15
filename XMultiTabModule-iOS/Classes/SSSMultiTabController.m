//
//  SSSMultiTabController.m
//  JDBrandSeckillModule
//
//  Created by 杨明 on 2022/3/28.
//

#import "SSSMultiTabController.h"
#import "SSSMutableTabContainerHelper.h"
#import "SSSUtils.h"
#import "UIColor+SSS.h"
#import <SDWebImage/SDWebImage.h>
#import "NSArray+SSSSafe.h"

typedef void (^SSSTabBarClickBlock)(NSInteger index);

@interface SSSBaseTabItemButton : UIButton

@property(nonatomic,strong) UIImageView     *customImageView;
@property(nonatomic,strong) SSSTabItemModel *tabModel;
@property(nonatomic,copy)   NSString        *pressImage;
@property(nonatomic,copy)   NSString        *nomalImage;

/**
 *   被选中
 */
-(void)pressed;

/**
 *   取消选中
 */
-(void)unPressed;

-(void)updateView:(SSSTabItemModel *)tabModel;

@end

@implementation SSSBaseTabItemButton

-(instancetype)initWithFrame:(CGRect)frame
                    tabModel:(SSSTabItemModel *)tabModel{
    if (self = [super initWithFrame:frame]) {
        self.tabModel = tabModel;
        CGFloat imageHeight = 50.f;
        if (tabModel.specialType == 1) {
            imageHeight = 60.f;
        }
        self.customImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,125.0,imageHeight)];
        self.customImageView.userInteractionEnabled = NO;
        self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
        CGPoint center = self.customImageView.center;
        center.x = self.frame.size.width/2;
        self.customImageView.center = center;
        self.nomalImage = @"placeholder_100x100";
        self.pressImage = @"placeholder_100x100";
        [self addSubview:self.customImageView];
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!self.superview) {
        NSLog(@"error");
    }
}

/**
 *   默认被选中
 */
-(void)defaultPressed
{
    [self.customImageView sd_setImageWithURL:[NSURL URLWithString:self.tabModel.selectTabImage ?: self.tabModel.tabImage]
                         placeholderImage:[UIImage imageNamed:self.pressImage]];
}

/**
 *   点击被选中
 */
-(void)pressed
{
    [self.customImageView sd_setImageWithURL:[NSURL URLWithString:self.tabModel.selectTabImage ?: self.tabModel.tabImage]
                         placeholderImage:[UIImage imageNamed:self.pressImage]];
}

/**
 *   取消选中
 */
-(void)unPressed
{
    [self.customImageView sd_setImageWithURL:[NSURL URLWithString:self.tabModel.tabImage ?: self.tabModel.selectTabImage]
                         placeholderImage:[UIImage imageNamed:self.nomalImage]];
}

-(void)updateView:(SSSTabItemModel*)tabModel
{
    self.tabModel = tabModel;
    [self unPressed];
}


@end

@interface SSSBaseTabbarView : UIView{
    NSUInteger  _tapIndex;
}

@property(nonatomic,strong) NSArray                 *buttons;
@property(nonatomic,strong) UIImageView             *bgImage;
@property(nonatomic,  copy) SSSTabBarClickBlock     clickBlock;

@property (nonatomic, assign) BOOL                  isTransingViewController; //是否正在切换
@property (nonatomic,strong) SSSBaseTabWrapperModel *wrapperModel;

@end

@implementation SSSBaseTabbarView

- (instancetype)initWithFrame:(CGRect)frame
                   clickBlock:(SSSTabBarClickBlock)clickBlock {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        _tapIndex = 0; // 默认选中第一个
        _isTransingViewController = NO;
        self.clickBlock = clickBlock;
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            
    _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,self.frame.size.height)];
    _bgImage.contentMode = UIViewContentModeScaleAspectFill;
    _bgImage.clipsToBounds = YES;
    [self addSubview:_bgImage];
}

- (void)defaultTabViewWithModel:(SSSBaseTabWrapperModel *)wrapperModel {
    self.wrapperModel = wrapperModel;
    [self p_defaultButtons:self.wrapperModel.tabList];
    [self p_defaultTabBgImage:nil];
}

- (void)p_defaultTabBgImage:(NSString *)bgImage {
    // 优先设置tab背景图
    if (validateString(bgImage)) {
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:bgImage]];
    } else {
        // 设置tab背景色
        if (self.wrapperModel.tabConfig.tabBackground.length > 0) {
            self.backgroundColor = [UIColor colorWithHex:self.wrapperModel.tabConfig.tabBackground];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)p_defaultButtons:(NSArray<SSSTabItemModel *> *)buttonModels {
    [self p_addButtons];
    if ([self.buttons count] == [buttonModels count]) {
        [buttonModels enumerateObjectsUsingBlock:^(SSSTabItemModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.buttons[idx] updateView:obj];
        }];
        [self.buttons[_tapIndex] defaultPressed];
    }
}

- (void)p_addButtons {
    if (!validateArray(self.wrapperModel.tabList)) return;
    NSInteger count = self.wrapperModel.tabList.count;
    CGFloat width = self.frame.size.width/count;
    CGFloat height = self.frame.size.height;
    NSMutableArray *tempButtons = [NSMutableArray array];
    for (int i= 0; i<self.wrapperModel.tabList.count; i++) {
        SSSTabItemModel *tabModel = self.wrapperModel.tabList[i];
        CGFloat top = 0;
        if (tabModel.specialType == 1) { // 超出的
            top = -10;
            height += 10;
        }
        SSSBaseTabItemButton *button = [[SSSBaseTabItemButton alloc] initWithFrame:CGRectMake(i*width, top, width, height)
                                                                          tabModel:tabModel
                                                                  ];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
       
        [self addSubview:button];
        [tempButtons addObject:button];
    }
    self.buttons = [NSArray arrayWithArray:tempButtons];
}

- (void)updateTabIconStatusWithIndex:(NSInteger)index {
    if (index >= self.buttons.count) return;
    [[self.buttons sss_safeObjectAtIndex:_tapIndex] unPressed];
    [[self.buttons sss_safeObjectAtIndex:index] pressed];
    _tapIndex = index;
}


- (void)buttonPressed:(SSSBaseTabItemButton *)sender {
    if (self.isTransingViewController) { //正在切换中
        return;
    }
    
    NSUInteger selectIndex = [self.buttons indexOfObject:sender];
    [sender pressed];                  //取消红点
    if (selectIndex != _tapIndex) {
        SSSBaseTabItemButton *oldButton = self.buttons[_tapIndex];
        [oldButton unPressed];
        _tapIndex = selectIndex;
    }
    
    if (self.clickBlock) {
        self.clickBlock(selectIndex);
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return nil;
    }
    UIView *result = [self findHitView:self point:point withEvent:event];
    if (!result) {
        result = [super hitTest:point withEvent:event];
    }
    return result;
}

- (UIView *)findHitView:(UIView *)view point:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subView in [view.subviews reverseObjectEnumerator]) {
        CGPoint convertPoint = [view convertPoint:point toView:subView];
        UIView *result = [subView hitTest:convertPoint withEvent:event];
        if (result) {
            return result;
        }
        UIView *subViewResult = [self findHitView:subView point:convertPoint withEvent:event];
        if (subViewResult) {
            return subViewResult;
        }
    }
    return nil;
}



@end



@interface SSSMultiTabController ()

@property(nonatomic,  copy)    NSString                     *innerlink;
@property(nonatomic,  copy)    NSString                     *tabLink;
@property (nonatomic, assign)  NSInteger                    currentTabIndex;          //当前选中的tab索引值
@property (nonatomic, weak  )  UIViewController             *currentViewController;   // 当前子VC
@property (nonatomic, strong)  SSSBaseTabbarView            *tabBarView;
@property (nonatomic, assign)  BOOL                         isTransViewController;
@property(nonatomic, strong)   NSMutableArray<UIViewController *> *tabVCs;
@property (nonatomic,strong)   SSSBaseTabWrapperModel       *wrapperModel;

@end

@implementation SSSMultiTabController

- (void)refreshWithTabModel:(SSSBaseTabWrapperModel *)tabModel {
    [self p_handleTabModel:tabModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.currentViewController.view.frame = [self p_getViewFrame];
    self.tabBarView.frame = [self p_getTabbarViewFrame];
}

- (void)initSubView {
    [self.view addSubview:self.tabBarView];
}

- (void)goToTabJumpIndex:(NSInteger)index {
    if (index >= self.tabVCs.count || index <0)  return;
    [self p_changeTabWithIndex:index];
    [self.tabBarView updateTabIconStatusWithIndex:index];
}

- (void)p_changeTabWithIndex:(NSInteger)index {
    if (index >= self.tabVCs.count || index <0)  return;
    if (self.currentTabIndex == index) {
        return;
    }
    self.currentTabIndex = index;
    [self p_changeVCWithIndex:index completion:^(UIViewController *currentVC) {
        
    }];
}

// 根据tabModel切换VC
- (void)p_changeVCWithIndex:(NSInteger)index completion:(void(^)(UIViewController *currentVC))completion {
    if (index >= self.tabVCs.count || index <0)  return;
    UIViewController *tabVC = self.tabVCs[index];
    [self p_changeFromVC:self.currentViewController toVC:tabVC completion:completion];
}

- (void)p_changeFromVC:(UIViewController *)oldVC toVC:(UIViewController *)newVC completion:(void(^)(UIViewController *currentVC))completion {
    if (self.isTransViewController) return;
    if (!oldVC || !newVC) return;
    
    self.isTransViewController = YES;
    self.tabBarView.isTransingViewController = YES;
    [oldVC willMoveToParentViewController:nil];
    
    __weak typeof(self) wself = self;
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.0f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        __strong typeof(wself) sself = wself;
        if (!sself) {
            return;
        };
        [newVC didMoveToParentViewController:sself];
        sself.currentViewController = newVC;
        
        sself.isTransViewController = NO;
        sself.tabBarView.isTransingViewController = NO;
        
        if (completion) {
            completion(newVC);
        }
    }];
    [self.view bringSubviewToFront:self.tabBarView];
}

- (void)p_clickTabWithIndex:(NSInteger)index {
    
    if (index >= self.wrapperModel.tabList.count || index <0)  return;
    [self p_changeTabWithIndex:index];
}

- (void)p_createAllChildVC {
    [self.wrapperModel.tabList enumerateObjectsUsingBlock:^(SSSTabItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [self p_createChildVCWithTabModel:obj index:idx];
        [self.tabVCs addObject:vc];
    }];
}

- (UIViewController *)p_createChildVCWithTabModel:(SSSTabItemModel *)tabModel index:(NSInteger)index {
    NSInteger tabType = tabModel.tabType;
    UIViewController *childVC = nil;
    if (tabType == SSSTabTypeWeb) {
        if ([self.delegate respondsToSelector:@selector(loadWebWithURL:)]) {
            UIViewController *webVC = [self.delegate loadWebWithURL:tabModel.link];
            childVC = [SSSUtils emberInNaviWithRootVC:webVC];
        } else {
            __weak typeof(self) wself = self;
            childVC = [SSSMutableTabContainerHelper createTTTNavWebVC:tabModel.link backBlock:^{
                [wself p_backActionWithIndex:index];
            }];
        }
    }
    if (tabType == SSSTabTypeNative) {
        UIViewController *nativeVC = [self.delegate loadNativeWithModule:tabModel.module params:tabModel.params];
        childVC = [SSSUtils emberInNaviWithRootVC:nativeVC];
    }
    if (!childVC || ![childVC isKindOfClass:[UIViewController class]]) {
        __weak typeof(self) wself = self;
        childVC = [SSSMutableTabContainerHelper createTTTNavWebVC:SSS_JD_URL backBlock:^{
            [wself p_backActionWithIndex:index];
        }];;
    }
    if (![self.childViewControllers containsObject:childVC]) {
        [self addChildViewController:childVC];
    }
    return childVC;
}

- (void)p_backActionWithIndex:(NSInteger)index {
    if (index == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self goToTabJumpIndex:0];
    }
}

- (void)p_handleTabModel:(SSSBaseTabWrapperModel *)tabModel {
    // 过滤无效数据
    NSMutableArray *tabs = [tabModel.tabList mutableCopy];
    NSMutableArray *needRemoveTabs = [NSMutableArray arrayWithCapacity:tabs.count];
    for (NSInteger index = 0; index < tabs.count; index++) {
        SSSTabItemModel *tab = tabs[index];
        if (tab.tabType == SSSTabTypeWeb && !validateString(tab.link)) {
            [needRemoveTabs addObject:tab];
        }
        if (tab.tabType == SSSTabTypeNative && !validateString(tab.module)) {
            [needRemoveTabs addObject:tab];
        }
    }
    [tabs removeObjectsInArray:needRemoveTabs];
    tabModel.tabList = [tabs copy];
    // 如果过滤后tab数不足，走兜底
    if (tabModel.tabList.count == 0) {
        tabModel = [SSSBaseTabWrapperModel getDefaultTabModel];
    }
    self.wrapperModel = tabModel;
    [self.tabBarView defaultTabViewWithModel:self.wrapperModel];

    // 创建所有childVC
    [self p_createAllChildVC];
    // 设置默认展示
    [self p_defaultShow];
    [self.view bringSubviewToFront:self.tabBarView];
}

- (void)p_defaultShow {
    NSInteger index = self.wrapperModel.tabConfig.selectIndex;
    if (index >= self.tabVCs.count || index < 0) {
        self.wrapperModel.tabConfig.selectIndex = 0;
        index = 0;
    }
    UIViewController *tabVC = self.tabVCs[index];
    self.currentViewController = tabVC;
    self.currentTabIndex = index;
    // fix 低版本 生命周期不触发
    [tabVC beginAppearanceTransition:YES animated:NO];
    [self.view addSubview:tabVC.view];
    [tabVC endAppearanceTransition];
    [tabVC didMoveToParentViewController:self];
    [self.tabBarView updateTabIconStatusWithIndex:index];
}

- (CGRect)p_getViewFrame {
    CGFloat isNotchHeight = self.view.frame.size.height - kTabViewiPhoneXHeight;
    CGFloat customHeight = self.view.frame.size.height - kTabViewHeight;
    CGFloat customeViewFrameHeight = [SSSUtils hasNotch] ?isNotchHeight : customHeight;
    // 如果tab数<2 隐藏底导
    if (self.wrapperModel && self.wrapperModel.tabList.count < 2) {
        customeViewFrameHeight = self.view.frame.size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), customeViewFrameHeight);
    return rect;
}

- (CGRect)p_getTabbarViewFrame {
    // 如果tab数<2 隐藏底导
    if (self.wrapperModel && self.wrapperModel.tabList.count < 2) {
        return CGRectMake(0.f, self.view.frame.size.height, SCREEN_WIDTH, 0.f);
    }
    CGRect rect;
    
    if(![SSSUtils hasNotch]){
        CGFloat beginY = self.view.frame.size.height - kTabViewHeight;
        rect = CGRectMake(0, beginY, SCREEN_WIDTH, kTabViewHeight);
    } else {
        CGFloat beginY = self.view.frame.size.height-kTabViewiPhoneXHeight;
        rect = CGRectMake(0, beginY, SCREEN_WIDTH, kTabViewiPhoneXHeight);
    }
    return rect;
}

- (SSSBaseTabbarView *)tabBarView {
    if (!_tabBarView) {
        __weak typeof(self) wself = self;
        _tabBarView = [[SSSBaseTabbarView alloc] initWithFrame:[self p_getTabbarViewFrame] clickBlock:^(NSInteger index) {
            [wself p_clickTabWithIndex:index];
        }];
    }
    return _tabBarView;
}

- (NSMutableArray<UIViewController *> *)tabVCs {
    if (!_tabVCs) {
        _tabVCs = [NSMutableArray array];
    }
    return _tabVCs;
}


@end
