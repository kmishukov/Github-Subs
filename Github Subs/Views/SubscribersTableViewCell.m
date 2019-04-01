//
//  SubscribersTableViewCell.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "SubscribersTableViewCell.h"
#import "Subscriber.h"

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
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@", subscriber.avatar_url]];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.avatar.image = image;
                    });
                }
            }
        }];
        [task resume];
    }
    
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
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@", subscriber.url]];
        NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:60.0];
        [theRequest setHTTPMethod:@"GET"];
        // Authorization to increase api calls limit
        [theRequest setValue:@"Basic a2ttaXNodWtvdkBnbWFpbC5jb206YzBtbWFuZG9T" forHTTPHeaderField:@"Authorization"];
        //
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:theRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSError *err;
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingAllowFragments error: &err];
                
                if (err) {
                    NSLog(@"Failed to serialize into JSON: %@", err);
                    return;
                }
                
                if ([jsonObject valueForKey:@"name"] != nil &&
                    [jsonObject valueForKey:@"company"] != nil &&
                    [jsonObject valueForKey:@"email"] != nil) {
                    subscriber.name = jsonObject[@"name"] != (id)[NSNull null] ? jsonObject[@"name"] : @"-";
                    subscriber.company = jsonObject[@"company"] != (id)[NSNull null] ? jsonObject[@"company"] : @"-" ;
                    subscriber.email = jsonObject[@"email"] != (id)[NSNull null] ? jsonObject[@"email"] : @"-";
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:0.5 animations:^{
                            self->_detailLabel.text = [NSString stringWithFormat:@"Name: %@\nCompany: %@\nE-mail: %@", subscriber.name, subscriber.company, subscriber.email ];
                            self->_detailLabel.alpha = 1;
                        }];
                    });
                } else {
                    NSLog(@"Failed to receive detailed data;");
                    return;
                }
            }
        }];
        [task resume];
    }
}

@end
