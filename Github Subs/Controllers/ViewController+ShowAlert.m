//
//  ViewController+ShowAlert.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController+ShowAlert.h"

@implementation ViewController (ShowAlert)
-(void)showAlertMessage:(NSString*)title withMessage:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: title
                                                                                 message: message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle: @"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        UIAlertAction *actionRetry = [UIAlertAction actionWithTitle: @"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSelector: @selector(getSubscribersList) withObject: nil afterDelay: 0];
        }];
        [alertController addAction:actionOk];
        [alertController addAction:actionRetry];
        [self presentViewController:alertController animated:YES completion:nil];
    });
};
@end
