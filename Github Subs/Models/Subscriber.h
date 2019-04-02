//
//  Subscriber.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Subscriber : NSObject

@property (strong,nonatomic) NSString *avatar_url;
@property (strong,nonatomic) NSString *login;
@property (strong,nonatomic) NSString *url;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *company;
@property (strong,nonatomic) NSString *email;

- (instancetype)initWithJson:(NSDictionary*)SubDict;

@end

NS_ASSUME_NONNULL_END
