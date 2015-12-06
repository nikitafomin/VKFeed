#import "_Friend.h"
#import "City.h"
#import "Country.h"

@interface Friend : _Friend {}

- (NSURL *)urlForPhoto;
- (City *)city;
- (Country *)country;

@end
