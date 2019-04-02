//
//  NetworkOperations.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 30/03/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Subscriber.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum result { Success, ErrorJSON, ErrorAPI, ErrorNetwork } Result;

@interface NetworkOperations : NSObject

+(void)getSubscribersListFor:(NSString*)user completionBlock:(void(^)(id response, Result result))completion;

@end

NS_ASSUME_NONNULL_END
