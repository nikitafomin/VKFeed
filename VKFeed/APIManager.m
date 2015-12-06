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
#import "City.h"
#import "Country.h"

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
        __block NSMutableString *citiesIDsTemp = [NSMutableString string];
        __block NSMutableString *countryIDsTemp = [NSMutableString string];
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            NSArray *friends = [responseObject objectForKey:@"response"];
            for (int i = 0; i < friends.count; i++) {
                NSDictionary *responseFriend = friends[i];
                Friend *friend = [Friend MR_importFromObject:responseFriend inContext:localContext];
                friend.orderValue = i;
                [citiesIDsTemp appendString:[NSString stringWithFormat:@"%@,",[responseFriend objectForKey:@"city"]]];
                [countryIDsTemp appendString:[NSString stringWithFormat:@"%@,",[responseFriend objectForKey:@"country"]]];
            }
        }];
        
        // remove last ',' character
        NSString *citiesIDs = [citiesIDsTemp substringToIndex:[citiesIDsTemp length] - 1];
        NSString *countryIDs = [countryIDsTemp substringToIndex:[countryIDsTemp length] - 1];
        
        // Create a dispatch group
        dispatch_group_t group = dispatch_group_create();
        
        // Enter the group for each request we create
        dispatch_group_enter(group);
        
        [self.operationManager GET:@"database.getCitiesById" parameters:@{@"city_ids": citiesIDs} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [City MR_importFromArray:[responseObject objectForKey:@"response"]];
            // Leave the group as soon as the request succeeded
            dispatch_group_leave(group);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DLog(@"Get Cities error - %@",error);
            failed(operaton, error);
            // Leave the group as soon as the request failed
            dispatch_group_leave(group);
        }];
        
        // Enter the group for each request we create
        dispatch_group_enter(group);
        
        [self.operationManager GET:@"database.getCountriesById" parameters:@{@"country_ids": countryIDs} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [Country MR_importFromArray:[responseObject objectForKey:@"response"]];
            // Leave the group as soon as the request succeeded
            dispatch_group_leave(group);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            DLog(@"Get Countries error - %@",error);
            failed(operaton, error);
            // Leave the group as soon as the request failed
            dispatch_group_leave(group);
        }];
        
        
        // Here we wait for all the requests to finish
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            // All requests are finished
            success([Friend MR_findAllSortedBy:@"order" ascending:YES]);
        });
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        DLog(@"Get Friends error - %@",error);
        failed(operaton, error);
    }];
    
    return operaton;
}

@end
