//
//  SubscribersJSON Parsing.m
//  Github SubsTests
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../Github Subs/Models/Subscriber.h"

@interface SubscribersJSON_Parsing : XCTestCase
@property Subscriber *sub;
@property NSDictionary *jsonDict;
@end

@implementation SubscribersJSON_Parsing

- (void)setUp {
    
    self.jsonDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @"Konstantin", @"login",
                     @"http://www.kmishukov.com/avatar.png", @"avatar_url",
                     @"http://www.kmishukov.com/", @"url",
                     nil
                    ];
    
    self.sub = [[Subscriber alloc] initWithJson: self.jsonDict];
}

- (void)tearDown {
    self.jsonDict = nil;
    self.sub = nil;
}

- (void)testExample {
    XCTAssertTrue([self.sub.login isEqualToString: self.jsonDict[@"login"]], @"Parsing value for key \"login\" failed.");
    XCTAssertTrue([self.sub.avatar_url isEqualToString: self.jsonDict[@"avatar_url"]], @"Parsing value for key \"avatar_url\" failed.");
    XCTAssertTrue([self.sub.url isEqualToString: self.jsonDict[@"url"]], @"Parsing value for key \"url\" failed.");
}

@end
