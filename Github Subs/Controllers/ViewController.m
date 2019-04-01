//
//  ViewController.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController.h"
#import "../Models/Subscriber.h"
#import "../Views/SubscribersTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Subscriber *> *subsArray;
@property (strong, nonatomic) NetworkOperations *networkOperations;
@property (strong, nonatomic) NSArray *subscribers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( self == [self.navigationController.viewControllers objectAtIndex:0] ){
        _login = @"octocat";
    }
    
    [[self navigationItem] setTitle: [NSString stringWithFormat:@"Subcribers of %@", _login]];
    [self configureTableView];
    
    _networkOperations = [[NetworkOperations alloc] init];
    [self getSubscribersList];
}

//MARK: TableView Delegate & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _subsArray.count > 0 ? 1 : 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _subsArray.count;
}

-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SubscribersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    cell = [[SubscribersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (_subsArray[indexPath.row] != nil) {
        [cell configureCell:_subsArray[indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = (int)[tableView indexPathForSelectedRow].row;
    NSString *selectedLogin = _subsArray[index].login;
    if (selectedLogin != nil) {
        ViewController *newViewController = [[ViewController alloc] initWithNewLogin: selectedLogin];
        [self.navigationController pushViewController:newViewController animated:YES];
    } else {
        NSLog(@"Unexpected error while passing user login.");
    }
}

//MARK: ViewController Methods
- (id)initWithNewLogin:(NSString*)newLogin {
    self = [super initWithNibName: nil bundle: nil];
    if (self) {
        self.login = [NSString stringWithFormat:@"%@",newLogin];
    }
    return self;
}

// TableView Configuration
-(void)configureTableView{
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 500;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview: self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerClass: SubscribersTableViewCell.class forCellReuseIdentifier: @"cell"];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.tableView.topAnchor constraintEqualToAnchor: self.view.topAnchor].active = YES;
    [self.tableView.leftAnchor constraintEqualToAnchor: self.view.leftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor: self.view.rightAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor].active = YES;
}

// Get Subscribers List
- (void)getSubscribersList {
    // Activity indicator @ RightBarButtonItem
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    [indicator startAnimating];
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]initWithCustomView: indicator];
    self.navigationItem.rightBarButtonItem = myButton;
    [_networkOperations getSubscribersListFor: _login completionBlock:^(id  _Nonnull response, Result result) {
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


// Alert Message
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
