//
//  NewFriendsTableViewCell.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/20.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "NewFriendsTableViewCell.h"
#import "Header.h"
#import "Marco.h"
#import "Config.h"

@implementation NewFriendsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self setupSubviewsProperty];
    }
    return self;
}

- (void)setupSubviews {
    self.imgViewIcon = [UIImageView new];
    [self.contentView addSubview:self.imgViewIcon];
    [self.imgViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).offset(10 * kScale);
        make.width.height.mas_equalTo(50 * kScale);
    }];
    
    self.lblTitle = [UILabel new];
    [self.contentView addSubview:self.lblTitle];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgViewIcon.mas_right).offset(10 * kScale);
        make.top.mas_equalTo(self.imgViewIcon.mas_top);
        make.width.mas_equalTo(230 * kScale);
        make.height.mas_equalTo(25 * kScale);
    }];
    
    self.lblDeatil = [UILabel new];
    [self.contentView addSubview:self.lblDeatil];
    [self.lblDeatil mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblTitle.mas_left);
        make.top.mas_equalTo(self.lblTitle.mas_bottom);
        make.width.height.mas_equalTo(self.lblTitle);
    }];
    
    self.btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.btnSure];
    [self.btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblTitle.mas_right).offset(10 * kScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10 * kScale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30 * kScale);
    }];
}

- (void)setupSubviewsProperty {
    self.imgViewIcon.image = IMAGE(@"iconPlace");
    self.lblTitle.font = FontWithSize(17);
    self.lblDeatil.font = FontWithSize(16);
    self.lblDeatil.textColor = [UIColor lightGrayColor];
    [self.btnSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnSure.titleLabel.font = FontWithSize(15);
    self.btnSure.backgroundColor = DESELECTED_COLOR;
    self.btnSure.layer.cornerRadius = 5 * kScale;
    [self.btnSure setTitle:@"接受" forState:UIControlStateNormal];
}

@end
