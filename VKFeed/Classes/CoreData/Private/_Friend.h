// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Friend.h instead.

#import <CoreData/CoreData.h>

extern const struct FriendAttributes {
	__unsafe_unretained NSString *cityID;
	__unsafe_unretained NSString *countryID;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *imageURL;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *order;
} FriendAttributes;

extern const struct FriendUserInfo {
	__unsafe_unretained NSString *relatedByAttribute;
} FriendUserInfo;

@interface FriendID : NSManagedObjectID {}
@end

@interface _Friend : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FriendID* objectID;

@property (nonatomic, strong) NSNumber* cityID;

@property (atomic) int64_t cityIDValue;
- (int64_t)cityIDValue;
- (void)setCityIDValue:(int64_t)value_;

//- (BOOL)validateCityID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* countryID;

@property (atomic) int64_t countryIDValue;
- (int64_t)countryIDValue;
- (void)setCountryIDValue:(int64_t)value_;

//- (BOOL)validateCountryID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageURL;

//- (BOOL)validateImageURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* order;

@property (atomic) int64_t orderValue;
- (int64_t)orderValue;
- (void)setOrderValue:(int64_t)value_;

//- (BOOL)validateOrder:(id*)value_ error:(NSError**)error_;

@end

@interface _Friend (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCityID;
- (void)setPrimitiveCityID:(NSNumber*)value;

- (int64_t)primitiveCityIDValue;
- (void)setPrimitiveCityIDValue:(int64_t)value_;

- (NSNumber*)primitiveCountryID;
- (void)setPrimitiveCountryID:(NSNumber*)value;

- (int64_t)primitiveCountryIDValue;
- (void)setPrimitiveCountryIDValue:(int64_t)value_;

- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSString*)primitiveImageURL;
- (void)setPrimitiveImageURL:(NSString*)value;

- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;

- (NSNumber*)primitiveOrder;
- (void)setPrimitiveOrder:(NSNumber*)value;

- (int64_t)primitiveOrderValue;
- (void)setPrimitiveOrderValue:(int64_t)value_;

@end
