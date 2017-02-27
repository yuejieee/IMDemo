//
//  MainViewController.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/14.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TriangleView.h"
#import "Marco.h"
#import "Header.h"
#import "Config.h"

#define btnW kScreen_Width/self.titleArray.count
#define btnH 70 * kScale
#define topDistance 180 * kScale

@interface MainViewController ()
<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIScrollView *titleScrollView;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) TriangleView *lineView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.btnArray = [NSMutableArray array];
    
    [self loadData];
    [self setupPageSubviews];
    [self setupPageSubviewsProperty];
}

- (void)setupPageSubviews {
    self.imgView = [[UIImageView alloc] init];
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(topDistance);
    }];
    
    self.lblTitle = [UILabel new];
    [self.imgView addSubview:self.lblTitle];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgView.mas_centerY).offset(-10 * kScale);
        make.left.right.mas_equalTo(self.imgView);
        make.height.mas_equalTo(30 * kScale);
    }];
    
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topDistance - btnH, kScreen_Width, btnH)];
    [self.view addSubview:self.titleScrollView];
    
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleScrollView addSubview:button];
        button.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        button.tag = 1000 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:17 weight:10];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:button];
    }
    
    self.lineView = [[TriangleView alloc] initWithFrame:CGRectMake(0, btnH - 10, btnW, 10)];
    [self.titleScrollView addSubview:self.lineView];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topDistance, kScreen_Width, kScreen_Height - btnH)];
    [self.view addSubview:self.contentScrollView];
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        [self.contentScrollView addSubview:self.childViewControllers[i].view];
        self.contentScrollView.subviews[i].frame = CGRectMake(i * kScreen_Width, 0, kScreen_Width, kScreen_Height - 64 - 160 * kScale);
    }
}

- (void)setupPageSubviewsProperty {
    self.lblTitle.text = @"IMDemo";
    self.lblTitle.font = [UIFont fontWithName:@"Lobster1.4" size:40 * kScale];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.textColor = [UIColor whiteColor];
    
    self.imgView.image = [UIImage imageNamed:@"top"];
    
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.contentSize = CGSizeMake(btnW, 0);
    self.titleScrollView.delegate = self;
    
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.titleArray.count * kScreen_Width, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
}

- (void)loadData {
    self.titleArray = @[@"注册", @"登陆"];
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self addChildViewController:registerVC];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self addChildViewController:loginVC];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        CGFloat offsetX = scrollView.contentOffset.x;
        self.lineView.frame = CGRectMake(offsetX/kScreen_Width * btnW, btnH - 10, btnW, 10);
    }
}

#pragma mark - event response
- (void)click:(UIButton *)button {
    NSInteger index = button.tag - 1000;
    [UIView animateWithDuration:0.2 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(index * kScreen_Width, 0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
