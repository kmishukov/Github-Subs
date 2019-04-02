//
//  NetworkOperations+GetUserDetails.h
//  Github Subs
//
//  Created by Konstantin Mishukov on 02/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "NetworkOperations.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkOperations (GetUserDetails)
+(void)getDetailsForUserUrl:(NSString*)userUrl completion: (void(^)(NSString* name, NSString* company, NSString* email))completion;
@end

NS_ASSUME_NONNULL_END
