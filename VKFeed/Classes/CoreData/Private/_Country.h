// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Country.h instead.

#import <CoreData/CoreData.h>

extern const struct CountryAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
} CountryAttributes;

extern const struct CountryUserInfo {
	__unsafe_unretained NSString *relatedByAttribute;
} CountryUserInfo;

@interface CountryID : NSManagedObjectID {}
@end

@interface _Country : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CountryID* objectID;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _Country (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end
