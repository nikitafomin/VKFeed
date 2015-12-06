//
//  FriendDetailViewController.m
//  VKFeed
//
//  Created by Никита Фомин on 07.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "FriendDetailViewController.h"

@interface FriendDetailViewController ()

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.friendImageView sd_setImageWithURL:self.detailedFriend.urlForPhoto placeholderImage:[UIImage imageNamed:@"default-avatar"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
