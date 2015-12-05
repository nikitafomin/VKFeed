//
//  AuthenticationViewController.m
//  VKFeed
//
//  Created by Никита Фомин on 05.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "VKAuthenticationManager.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadAuthenticationPage];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)loadAuthenticationPage {
    NSURLRequest *request = [NSURLRequest requestWithURL:[[VKAuthenticationManager sharedManager] signInURL]];
    [self.webView loadRequest:request];
}

#pragma mark - WebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *urlString = webView.request.URL.absoluteString;
    DLog(@"Loaded request:\n\n%@",urlString);
    
    if ([urlString rangeOfString:@"access_token"].location != NSNotFound) {
        
        // token
        NSString *accessToken = [self stringBetweenString:@"access_token=" secondString:@"&" inString:urlString];
        
        // user id
        NSString *userID = [self stringBetweenString:@"user_id=" secondString:@"&" inString:urlString];
        
        [[VKAuthenticationManager sharedManager] saveAccessToken:accessToken userID:userID];
        [ApplicationDelegate showNeededViewController];
    }
}

- (NSString *)stringBetweenString:(NSString *)first secondString:(NSString *)second inString:(NSString *)initialString {
    
    NSString *string = initialString;
    NSRange range;
    
    range = [initialString rangeOfString:first];
    if (range.location != NSNotFound) {
        NSString *strinBefore = [initialString substringToIndex:(range.location + range.length)];
        string = [string stringByReplacingOccurrencesOfString:strinBefore withString:@""];
    }
    
    range = [string rangeOfString:second];
    if (range.location != NSNotFound) {
        NSString *strinAfter = [string substringFromIndex:range.location];
        string = [string stringByReplacingOccurrencesOfString:strinAfter withString:@""];
    }
    
    return string;
}

@end
