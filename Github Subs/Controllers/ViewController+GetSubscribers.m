//
//  ViewController+GetSubscribers.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController+GetSubscribers.h"

@implementation ViewController (GetSubscribers)

// Get Subscribers List
- (void)getSubscribersList {
    // Activity indicator @ RightBarButtonItem
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    [indicator startAnimating];
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]initWithCustomView: indicator];
    self.navigationItem.rightBarButtonItem = myButton;
    [NetworkOperations getSubscribersListFor: [self login] completionBlock:^(id  _Nonnull response, Result result) {
        // Activity indicator stop
        dispatch_async(dispatch_get_main_queue(), ^{
            [indicator stopAnimating];
        });
        switch (result) {
            case Success: {
                self.subsArray = response;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                break;
            }
            case ErrorAPI: {
                NSString *title = @"API Error";
                NSString *description = @"API Error Description?";
                if (response != nil) {
                    NSArray<NSString*> *errorStrings = (id)response;
                    if (errorStrings.count == 2) {
                        title = errorStrings[0];
                        description = errorStrings[1];
                    }
                }
                [self showAlertMessage: title withMessage: description];
                break;
            }
            case ErrorJSON: {
                NSString* description = @"Could not parse JSON.";
                if (response != nil) {
                    NSError *error = (id)response;
                    description = [error localizedDescription];
                }
                [self showAlertMessage: @"JSON Error" withMessage: description];
                break;
            }
            case ErrorNetwork: {
                NSString* description = @"Network Error Description?";
                if (response != nil) {
                    NSError *error = (id)response;
                    description = [error localizedDescription];
                }
                [self showAlertMessage: @"Network Error" withMessage: description];
                break;
            }
        }
    }];
}

@end
