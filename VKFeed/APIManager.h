//
//  APIManager.h
//  VKFeed
//
//  Created by Никита Фомин on 05.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

@property (nonatomic, readonly) AFHTTPRequestOperationManager *operationManager;


+ (instancetype)sharedManager;



#pragma mark - GET methods

- (AFHTTPRequestOperation *)getFriends:(void (^)(NSArray *friends))success failed:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failed;

@end
