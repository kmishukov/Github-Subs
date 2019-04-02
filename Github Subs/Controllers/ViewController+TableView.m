//
//  ViewController+TableView.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController+TableView.h"

@implementation ViewController (TableView)

//MARK: TableView Configuration
-(void)configureTableView{
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerClass: SubscribersTableViewCell.class forCellReuseIdentifier: @"cell"];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.tableView.topAnchor constraintEqualToAnchor: self.view.topAnchor].active = YES;
    [self.tableView.leftAnchor constraintEqualToAnchor: self.view.leftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor: self.view.rightAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor].active = YES;
}

//MARK: TableView Delegate & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self subsArray].count > 0 ? 1 : 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self subsArray].count;
}

-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SubscribersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    cell = [[SubscribersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if ([self subsArray][indexPath.row] != nil) {
        [cell configureCell:[self subsArray][indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = (int)[tableView indexPathForSelectedRow].row;
    NSString *selectedLogin = [self subsArray][index].login;
    if (selectedLogin != nil) {
        ViewController *newViewController = [[ViewController alloc] initWithNewLogin: selectedLogin];
        [self.navigationController pushViewController:newViewController animated:YES];
    } else {
        NSLog(@"Unexpected error while passing user login.");
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
