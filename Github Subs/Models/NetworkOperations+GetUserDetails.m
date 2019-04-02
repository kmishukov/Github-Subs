//
//  NetworkOperations+GetUserDetails.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "NetworkOperations+GetUserDetails.h"

@implementation NetworkOperations (GetUserDetails)

+(void)getDetailsForUserUrl:(NSString*)userUrl completion: (void(^)(NSString* name, NSString* company, NSString* email))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@", userUrl]];
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
                completion(
                           jsonObject[@"name"] != (id)[NSNull null] ? jsonObject[@"name"] : @"-",
                           jsonObject[@"company"] != (id)[NSNull null] ? jsonObject[@"company"] : @"-",
                           jsonObject[@"email"] != (id)[NSNull null] ? jsonObject[@"email"] : @"-"
                );
            } else {
                NSLog(@"Failed to receive detailed data;");
                return;
            }
        }
    }];
    [task resume];
}
@end
