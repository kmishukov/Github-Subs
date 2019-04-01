//
//  NetworkOperations.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "NetworkOperations.h"
#import "Subscriber.h"

@implementation NetworkOperations

-(void)getSubscribersListFor:(NSString*)user completionBlock:(void(^)(id response, Result result))completion {
    NSString *urlAsString = [NSString stringWithFormat: @"https://api.github.com/users/%@/followers", user];
    NSURL *urlpath = [[NSURL alloc] initWithString:urlAsString];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:urlpath
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:10.0];
    [theRequest setHTTPMethod:@"GET"];
    // Authorization to increase api calls limit
    [theRequest setValue:@"Basic a2ttaXNodWtvdkBnbWFpbC5jb206YzBtbWFuZG9T" forHTTPHeaderField: @"Authorization"];
    //
    NSLog(@"Accessing URL: %@", urlAsString);
    [[[NSURLSession sharedSession] dataTaskWithRequest: theRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data!=nil) {
            NSError *err;
            id jsonObject = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingAllowFragments error: &err];
            
            if (err) {
                NSLog(@"Failed to serialize into JSON: %@", err);
                completion(err, ErrorJSON);
                return;
            }
            
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSMutableArray<Subscriber *> *subsArray = NSMutableArray.new;
                for (NSDictionary *subDict in jsonObject) {
                    Subscriber *sub = Subscriber.new;
                    NSString *login = subDict[@"login"];
                    sub.login = login;
                    NSString *imageUrl = subDict[@"avatar_url"];
                    sub.avatar_url = imageUrl;
                    NSString *url = subDict[@"url"];
                    sub.url = url;
                    [subsArray addObject:sub];
                }
                completion(subsArray, Success);
            } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSString *message = jsonObject[@"message"];
                NSString *documentationUrl = jsonObject[@"documentation_url"];
                NSMutableArray *error = [[NSMutableArray alloc] init];
                [error addObject:message];
                [error addObject:documentationUrl];
                completion(error, ErrorAPI);
            }
        } else {
            completion(error, ErrorNetwork);
        }
    }] resume ] ;
}

@end
