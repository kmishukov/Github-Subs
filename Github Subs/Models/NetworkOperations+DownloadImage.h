//
//  NetworkOperations+DownloadImage.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkOperations.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkOperations (DownloadImage)

+(void)downloadImageFromUrl:(NSString*)imageUrl completion: (void(^)(UIImage* image))completion;

@end

NS_ASSUME_NONNULL_END
