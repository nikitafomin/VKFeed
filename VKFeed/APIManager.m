//
//  APIManager.m
//  VKFeed
//
//  Created by Никита Фомин on 05.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "APIManager.h"
#import "VKAuthenticationManager.h"
#import "Friend.h"

@implementation APIManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSURL *)baseURL {
    static dispatch_once_t once;
    static NSURL *url;
    dispatch_once(&once, ^{
        url = [NSURL URLWithString:@"https://api.vk.com/method/"];
    });
    return url;
}

- (NSMutableDictionary *)baseParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[[VKAuthenticationManager sharedManager] userID] forKey:@"user_id"];
    [params setObject:[[VKAuthenticationManager sharedManager] accessToken] forKey:@"access_token"];
    return params;
}

- (AFHTTPRequestOperationManager *)operationManager {
    static dispatch_once_t once;
    static AFHTTPRequestOperationManager *manager;
    dispatch_once(&once, ^{
        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[self baseURL]];
        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    });
    return manager;
}

#pragma mark - GET methods

- (AFHTTPRequestOperation *)getFriends:(void (^)(NSArray *friends))success failed:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failed
{
    NSMutableDictionary *params = [self baseParams];
    [params setObject:@"hints" forKey:@"order"];
    [params setObject:@"nickname,city,country,photo_200_orig" forKey:@"fields"];
    
    AFHTTPRequestOperation *operaton = [self.operationManager GET:@"friends.get" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        DLog(@"%@",responseObject);
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            [Friend MR_importFromArray:[responseObject objectForKey:@"response"] inContext:localContext];
        }];
        success([Friend MR_findAll]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        DLog(@"Get Friends error - %@",error);
        failed(operaton, error);
    }];
    
    return operaton;
}

@end
