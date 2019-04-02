//
//  ViewController+ShowAlert.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+GetSubscribers.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController (ShowAlert)
-(void)showAlertMessage:(NSString*)title withMessage:(NSString*)message;
@end

NS_ASSUME_NONNULL_END
