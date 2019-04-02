//
//  Subscriber.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "Subscriber.h"

@implementation Subscriber

- (instancetype)initWithJson:(NSDictionary*)subDict {
    self = [super init];
    if (self) {
        NSString *login = subDict[@"login"];
        self.login = login;
        NSString *imageUrl = subDict[@"avatar_url"];
        self.avatar_url = imageUrl;
        NSString *url = subDict[@"url"];
        self.url = url;
    }
    return self;
}

@end
