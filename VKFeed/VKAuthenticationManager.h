//
//  VKAuthenticationManager.h
//  VKFeed
//
//  Created by Никита Фомин on 05.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKAuthenticationManager : NSObject

+ (instancetype)sharedManager;

- (NSURL *)signInURL;

- (void)saveAccessToken:(NSString *)token userID:(NSString *)userID;

- (BOOL)isUserAuthenticate;
- (void)logout;

@end
