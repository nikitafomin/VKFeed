// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Friend.m instead.

#import "_Friend.h"

const struct FriendAttributes FriendAttributes = {
	.cityID = @"cityID",
	.countryID = @"countryID",
	.firstName = @"firstName",
	.id = @"id",
	.imageURL = @"imageURL",
	.lastName = @"lastName",
	.order = @"order",
};

const struct FriendUserInfo FriendUserInfo = {
	.relatedByAttribute = @"id",
};

@implementation FriendID
@end

@implementation _Friend

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Friend";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:moc_];
}

- (FriendID*)objectID {
	return (FriendID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"cityIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cityID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"countryIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"countryID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"orderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"order"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic cityID;

- (int64_t)cityIDValue {
	NSNumber *result = [self cityID];
	return [result longLongValue];
}

- (void)setCityIDValue:(int64_t)value_ {
	[self setCityID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveCityIDValue {
	NSNumber *result = [self primitiveCityID];
	return [result longLongValue];
}

- (void)setPrimitiveCityIDValue:(int64_t)value_ {
	[self setPrimitiveCityID:[NSNumber numberWithLongLong:value_]];
}

@dynamic countryID;

- (int64_t)countryIDValue {
	NSNumber *result = [self countryID];
	return [result longLongValue];
}

- (void)setCountryIDValue:(int64_t)value_ {
	[self setCountryID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveCountryIDValue {
	NSNumber *result = [self primitiveCountryID];
	return [result longLongValue];
}

- (void)setPrimitiveCountryIDValue:(int64_t)value_ {
	[self setPrimitiveCountryID:[NSNumber numberWithLongLong:value_]];
}

@dynamic firstName;

@dynamic id;

- (int64_t)idValue {
	NSNumber *result = [self id];
	return [result longLongValue];
}

- (void)setIdValue:(int64_t)value_ {
	[self setId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithLongLong:value_]];
}

@dynamic imageURL;

@dynamic lastName;

@dynamic order;

- (int64_t)orderValue {
	NSNumber *result = [self order];
	return [result longLongValue];
}

- (void)setOrderValue:(int64_t)value_ {
	[self setOrder:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveOrderValue {
	NSNumber *result = [self primitiveOrder];
	return [result longLongValue];
}

- (void)setPrimitiveOrderValue:(int64_t)value_ {
	[self setPrimitiveOrder:[NSNumber numberWithLongLong:value_]];
}

@end

