//
//  TMSimpleTestViewController.m
//  TMMasonryExtends_Example
//
//  Created by XiaobinLin on 2019/9/6.
//  Copyright © 2019 lxb_0605@qq.com. All rights reserved.
//

#import "TMSimpleTestViewController.h"
#import <Masonry/Masonry.h>
#import <TMMasonryExtends/TMMasonryExtends.h>
#import <CYLDeallocBlockExecutor/CYLDeallocBlockExecutor.h>

@interface TMSimpleTestViewController ()

@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIButton *btnToggle;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *lbMore;

@end

@implementation TMSimpleTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self createUI];
}

- (void)createUI
{
    [self.view addSubview:self.lbTitle];
    [self.view addSubview:self.btnToggle];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.lbMore];
    
    [self.imageView cyl_willDeallocWithSelfCallback:^(__unsafe_unretained id owner, NSUInteger identifier) {
        NSLog(@"%@ dealloc", owner);
    }];
    
    MASAttachKeys(self.lbTitle, self.btnToggle, self.imageView, self.lbMore);
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.centerX.mas_offset(0);
    }];
    
    [self.btnToggle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom).offset(20);
        make.centerX.mas_offset(0);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        // self.imageView 隐藏时，顶部间距自动设置为 0
        make.top.equalTo(self.btnToggle.mas_bottom).offset(50).tm_collapseWhenHidden(self.imageView);
        // self.imageView 隐藏时，高度设置为 0
        make.height.mas_equalTo(0).tm_installWhenHidden(self.imageView);
        // self.imageView 显示时，高度设置为 120
        make.height.mas_equalTo(120).tm_installWhenShow(self.imageView);
        make.width.equalTo(self.imageView.mas_height);
        make.centerX.mas_offset(0);
    }];
    
    [self.lbMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
        make.centerX.mas_offset(0);
    }];
}

#pragma mark - create ui
- (UILabel *)lbTitle
{
    if (!_lbTitle) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"Nice to meet you!";
        _lbTitle = label;
    }
    return _lbTitle;
}

- (UIButton *)btnToggle
{
    if (!_btnToggle) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"Collapse" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onToggleAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnToggle = button;
    }
    return _btnToggle;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)lbMore
{
    if (!_lbMore) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"Imageview will collapse/expand";
        _lbMore = label;
    }
    return _lbMore;
}

#pragma mark - actions
- (void)onToggleAction:(UIButton *)button
{
    self.imageView.hidden = !self.imageView.hidden;
    
    NSString *title = self.imageView.hidden ? @"Expand" : @"Collapse";
    [self.btnToggle setTitle:title forState:UIControlStateNormal];
}

@end
