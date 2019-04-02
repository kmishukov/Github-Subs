//
//  NetworkOperations+DownloadImage.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "NetworkOperations.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkOperations (DownloadImage)

+(void)downloadImageFromUrl:(NSString*)imageUrl completion: (void(^)(UIImage* image))completion;

@end

NS_ASSUME_NONNULL_END
