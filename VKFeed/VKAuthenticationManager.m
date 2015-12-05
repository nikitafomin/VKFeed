//
//  VKAuthenticationManager.m
//  VKFeed
//
//  Created by Никита Фомин on 05.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "VKAuthenticationManager.h"

@implementation VKAuthenticationManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isUserAuthenticate {
    return ([[NSUserDefaults standardUserDefaults] stringForKey:kAccessToken].length > 0);
}

- (NSURL *)signInURL {
    NSString *urlString = [NSString stringWithFormat:@"https://oauth.vk.com/authorize?"
                           "client_id=%@&"
                           "display=touch&"
                           "redirect_uri=https://oauth.vk.com/blank.html&"
                           "scope=friends,wall&"
                           "response_type=token&"
                           "v=5.40",
                           kVKAppID];
    return [NSURL URLWithString:urlString];
}

- (void)saveAccessToken:(NSString *)token userID:(NSString *)userID {
    [SSKeychain setPassword:token forService:kKeychainService account:kAccessToken];
    [SSKeychain setPassword:userID forService:kKeychainService account:kUserID];
}

- (NSString *)accessToken {
    return [SSKeychain passwordForService:kKeychainService account:kAccessToken];
}

- (NSString *)userID {
    return [SSKeychain passwordForService:kKeychainService account:kUserID];
}

- (void)logout {
    if ([self isUserAuthenticate]) {
        [SSKeychain deletePasswordForService:kKeychainService account:kAccessToken];
        [SSKeychain deletePasswordForService:kKeychainService account:kUserID];
    }
}

@end
