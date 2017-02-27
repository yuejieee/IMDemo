//
//  NewFriendsViewController.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/20.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "NewFriendsViewController.h"
#import "NewFriendsTableViewCell.h"
#import "Contact.h"
#import "DataBaseHandler.h"
#import "Header.h"
#import "Config.h"
#import "Marco.h"

@interface NewFriendsViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayContact;

@property (nonatomic, strong) UILabel *lblPlace;

@end

@implementation NewFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"IMDemo";
    [self setupPageSubviews];
    [self setupPageSubviewsProperty];
    [self loadData];
}

- (void)setupPageSubviews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.lblPlace = [UILabel new];
    [self.view addSubview:self.lblPlace];
    [self.lblPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-64);
        make.height.mas_equalTo(30 * kScale);
    }];
}

- (void)setupPageSubviewsProperty {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.lblPlace.hidden = YES;
    self.lblPlace.text = @"暂无好友申请";
    self.lblPlace.textAlignment = NSTextAlignmentCenter;
    self.lblPlace.textColor = [UIColor lightGrayColor];
    self.lblPlace.font = FontWithSize(18);
}

- (void)loadData {
    self.arrayContact = [[DataBaseHandler shareDataBase] selectAllData];
    if (self.arrayContact.count != 0) {
        self.lblPlace.hidden = YES;
    } else {
        self.lblPlace.hidden = NO;
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayContact.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70 * kScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"tableViewCell";
    NewFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[NewFriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.arrayContact.count != 0) {
        Contact *contact = self.arrayContact[indexPath.row];
        cell.lblTitle.text = contact.username;
        cell.lblDeatil.text = contact.message;
        cell.btnSure.tag = 1000 + indexPath.row;
        [cell.btnSure addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)sureAction:(UIButton *)sender {
    Contact *contact = self.arrayContact[sender.tag - 1000];
    [UserManagers acceptFriendsForUsername:contact.username completion:^(BOOL success) {
        if (success) {
            [[DataBaseHandler shareDataBase] deleteData:contact];
            [self loadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
