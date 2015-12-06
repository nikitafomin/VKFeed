//
//  FriendsTableViewCell.m
//  VKFeed
//
//  Created by Никита Фомин on 06.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import "FriendsTableViewCell.h"

@implementation FriendsTableViewCell

- (void)configureWithFriend:(Friend *)friendObj {
    [self.friendImageView sd_setImageWithURL:friendObj.urlForPhoto placeholderImage:[UIImage imageNamed:@"default-avatar"]];
    self.firstNameLabel.text = friendObj.firstName;
    self.lastNameLabel.text = friendObj.lastName;
    self.locationLabel.text = friendObj.locationDescription;
}

@end
