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

- (NSString *)locationDescription {
    NSString *city = self.city.name;
    NSString *country = self.country.name;
    
    if (city) {
        if (country) {
            return [NSString stringWithFormat:@"%@, %@", country, city];
        } else {
            return city;
        }
    } else if (country) {
        return country;
    }
    
    return nil;
}

@end
