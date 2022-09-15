//
//  JDBViewController.m
//  XMultiTabModule-iOS
//
//  Created by lixianke1 on 08/23/2022.
//  Copyright (c) 2022 lixianke1. All rights reserved.
//

#import "JDBViewController.h"

@interface JDBViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JDBViewController

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.titleLabel.text = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.titleLabel];
    [self.titleLabel sizeToFit];
    self.titleLabel.center = self.view.center;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}

@end
