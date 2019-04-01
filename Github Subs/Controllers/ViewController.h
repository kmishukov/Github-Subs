//
//  ViewController.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Models/NetworkOperations.h"


@interface ViewController : UIViewController 

@property (nonatomic) NSString *login;

- (id)initWithNewLogin:(NSString*)newLogin;

@end

