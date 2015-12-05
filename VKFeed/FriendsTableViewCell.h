//
//  FriendsTableViewCell.h
//  VKFeed
//
//  Created by Никита Фомин on 06.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface FriendsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *friendPhoto;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;

- (void)configureWithFriend:(Friend *)friendObj;

@end
