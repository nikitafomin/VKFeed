#import "Friend.h"

@interface Friend ()

// Private interface goes here.

@end

@implementation Friend

- (NSURL *)urlForPhoto {
    return [NSURL URLWithString:self.imageURL];
}

- (City *)city {
    return [City MR_findFirstByAttribute:@"id" withValue:self.cityID];
}

- (Country *)country {
    return [Country MR_findFirstByAttribute:@"id" withValue:self.countryID];
}

@end
