#import "Friend.h"

@interface Friend ()

// Private interface goes here.

@end

@implementation Friend

- (NSURL *)urlForPhoto {
    return [NSURL URLWithString:self.imageURL];
}

@end
