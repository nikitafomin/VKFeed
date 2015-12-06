//
//  FriendsTableViewController.m
//  VKFeed
//
//  Created by Никита Фомин on 06.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "FriendsTableViewCell.h"
#import "VKAuthenticationManager.h"
#import "FriendDetailViewController.h"

@interface FriendsTableViewController ()

@property (nonatomic, strong) NSArray *friends;

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // auto cell height
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)refresh {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[APIManager sharedManager] getFriends:^(NSArray *friends) {
        [SVProgressHUD dismiss];
        self.friends = friends;
        [self.tableView reloadData];
    } failed:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        
        // try to get local friends
        NSArray *localFriends = [Friend MR_findAll];
        if (localFriends.count > 0) {
            self.friends = localFriends;
            [self.tableView reloadData];
        }
        
        [[[UIAlertView alloc] initWithTitle:@"Server error" message:@"Please try next time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (IBAction)logoutTapped:(id)sender {
    [[VKAuthenticationManager sharedManager] logout];
}

- (IBAction)clearCacheTapped:(id)sender {
    // remove cookies
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    // remove cached images
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FriendsTableViewCell class]) forIndexPath:indexPath];
    
    [cell configureWithFriend:self.friends[indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FriendDetailViewController *controller = (FriendDetailViewController *)segue.destinationViewController;
    NSInteger index = [self.tableView indexPathForCell:sender].row;
    controller.detailedFriend = self.friends[index];
}

@end
