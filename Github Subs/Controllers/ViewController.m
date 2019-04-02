//
//  ViewController.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+TableView.h"
#import "ViewController+GetSubscribers.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initial ViewController shows Octocat subscribers;
    if ( self == [self.navigationController.viewControllers objectAtIndex:0] ){
        _login = @"octocat";
    }
    
    [[self navigationItem] setTitle: [NSString stringWithFormat:@"Subcribers of %@", _login]];
    [self configureTableView]; // Init & Constraints 
    [self getSubscribersList]; // Retrieve subscribers list for user
}

//MARK: ViewController Methods
- (id)initWithNewLogin:(NSString*)newLogin {
    self = [super initWithNibName: nil bundle: nil];
    if (self) {
        self.login = [NSString stringWithFormat:@"%@",newLogin];
    }
    return self;
}
@end
