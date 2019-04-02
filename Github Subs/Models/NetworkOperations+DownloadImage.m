//
//  NetworkOperations+DownloadImage.m
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "NetworkOperations+DownloadImage.h"

@implementation NetworkOperations (DownloadImage)

+(void)downloadImageFromUrl:(NSString*)imageUrl completion: (void(^)(UIImage* image))completion {
    if (imageUrl != nil) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@", imageUrl]];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    completion(image);
                }
            }
        }];
        [task resume];
    }
}


@end

