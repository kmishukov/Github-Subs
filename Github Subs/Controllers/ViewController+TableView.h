//
//  ViewController+TableView.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController.h"
#import "../Views/SubscribersTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController (TableView) <UITableViewDelegate, UITableViewDataSource>

-(void)configureTableView;

@end

NS_ASSUME_NONNULL_END
