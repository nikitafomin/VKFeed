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

@property (weak, nonatomic) IBOutlet UIImageView *friendImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

- (void)configureWithFriend:(Friend *)friendObj;

@end
