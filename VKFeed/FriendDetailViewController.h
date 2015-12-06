//
//  FriendDetailViewController.h
//  VKFeed
//
//  Created by Никита Фомин on 07.12.15.
//  Copyright © 2015 Nikita Fomin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface FriendDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *friendImageView;

@property (nonatomic, strong) Friend *detailedFriend;

@end
