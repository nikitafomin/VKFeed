//
//  VKAuthenticationManager.m
//  VKFeed
//
//  Created by Никита Фомин on 05.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "VKAuthenticationManager.h"
#import "Friend.h"

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
    return ([self accessToken].length > 0 && [self userID].length > 0);
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
        
        
        // remove cookies
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        // reset DB
        [MagicalRecord cleanUp];
        
        NSString *dbStore = [MagicalRecord defaultStoreName];
        
        NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:dbStore];
        NSURL *walURL = [[storeURL URLByDeletingPathExtension] URLByAppendingPathExtension:@"sqlite-wal"];
        NSURL *shmURL = [[storeURL URLByDeletingPathExtension] URLByAppendingPathExtension:@"sqlite-shm"];
        
        NSError *error = nil;
        
        for (NSURL *url in @[storeURL, walURL, shmURL]) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
                [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
            }
        }
        
        [MagicalRecord setupCoreDataStack];
        
        
        // go to authenticate view
        [ApplicationDelegate showNeededViewController];
    }
}

@end
