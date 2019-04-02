//
//  ViewController+GetSubscribers.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+ShowAlert.h"
#import "../Models/NetworkOperations.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController (GetSubscribers)

//@property (strong, nonatomic) NetworkOperations *networkOperations;
- (void)getSubscribersList;

@end

NS_ASSUME_NONNULL_END
