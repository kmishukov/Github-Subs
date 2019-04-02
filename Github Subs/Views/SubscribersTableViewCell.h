//
//  SubscribersTableViewCell.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subscriber.h"
#import "../Models/NetworkOperations+DownloadImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubscribersTableViewCell : UITableViewCell
-(void)configureCell:(Subscriber*)subscriber;
@end

NS_ASSUME_NONNULL_END
