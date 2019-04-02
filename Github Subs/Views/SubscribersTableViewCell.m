//
//  SubscribersTableViewCell.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "SubscribersTableViewCell.h"
#import "Subscriber.h"

#import "../Models/NetworkOperations+GetUserDetails.h"

@interface SubscribersTableViewCell ()

@property UILabel *loginLabel;
@property UIImageView *avatar;
@property UILabel *detailLabel;

@end

@implementation SubscribersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier subscriber:(Subscriber*)subscriber {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)configureCell:(Subscriber*)subscriber{
    
    // Avatar ImageView
    _avatar = [[UIImageView alloc] init];
    [self.contentView addSubview:_avatar];
    _avatar.contentMode = UIViewContentModeScaleAspectFit;
    _avatar.translatesAutoresizingMaskIntoConstraints = NO;
    _avatar.layer.cornerRadius = 40;
    _avatar.clipsToBounds = YES;
    [_avatar.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 20].active = YES;
    [_avatar.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -20].active = YES;
    [_avatar.widthAnchor constraintEqualToConstant: 80].active = YES;
    [_avatar.heightAnchor constraintEqualToConstant: 80].active = YES;
    _avatar.image = [UIImage imageNamed: @"placeholder.png"];
    
    // Fetch Image from Avatar_URL
    if (subscriber.avatar_url != nil) {
        [NetworkOperations downloadImageFromUrl: subscriber.avatar_url  completion:^(UIImage* image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.avatar.image = image;
                });
        }];
    };
    
    // Login Label
    _loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 200, 21)];
    [self.contentView addSubview:_loginLabel];
    _loginLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_loginLabel.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 20].active = YES;
    [_loginLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.avatar.leadingAnchor constant: -10].active = YES;
    [_loginLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant: 20].active = YES;
    _loginLabel.text = subscriber.login != nil ? [NSString stringWithFormat:@"Login: %@", subscriber.login] : @"Login: ???";
    
    // Detail Label
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 21)];
    [self.contentView addSubview:_detailLabel];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.numberOfLines = 0;
    [_detailLabel.topAnchor constraintEqualToAnchor: self.loginLabel.bottomAnchor].active = YES;
    [_detailLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.avatar.leadingAnchor constant: -10].active = YES;
    [_detailLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant: 20].active = YES;
    [_detailLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant: -10].active = YES;
    if (subscriber.name == nil && subscriber.company == nil && subscriber.email == nil) {
        _detailLabel.alpha = 0;
    } else {
        _detailLabel.text = [NSString stringWithFormat:@"Name: %@\nCompany: %@\nE-mail: %@", subscriber.name, subscriber.company, subscriber.email ];
    }
    
    // Fetching Details from User URL
    if ((subscriber.url != nil) && (subscriber.name == nil && subscriber.company == nil && subscriber.email == nil)) {
        [NetworkOperations getDetailsForUserUrl: subscriber.url completion:^(NSString * _Nonnull name, NSString * _Nonnull company, NSString * _Nonnull email) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    self->_detailLabel.text = [NSString stringWithFormat:@"Name: %@\nCompany: %@\nE-mail: %@", name, company, email ];
                    self->_detailLabel.alpha = 1;
                }];
            });
        }];
    }
}

@end
