//
//  AppDelegate.m
//  VKFeed
//
//  Created by Никита Фомин on 05.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "AppDelegate.h"
#import "VKAuthenticationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    DLog(@"DEVICE ID: %@",[UIDevice currentDevice].identifierForVendor.UUIDString);
    DLog(@"PATH TO SIMULATOR: %@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    
    // MagicaRecord
    [MagicalRecord setupCoreDataStack];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
    
    // AFNetworking
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // SSKeychain
    [SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
    
    
    [self showNeededViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - Switching Controllers

- (void)showNeededViewController {
    
    NSString *identifer = [[VKAuthenticationManager sharedManager] isUserAuthenticate] ? @"RootNavigationController" : @"AuthenticationViewController";
    
    UIStoryboard *storyboard = self.window.rootViewController.storyboard;
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:identifer];
    [self.window setRootViewController:controller];
}

@end
