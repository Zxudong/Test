//
//  Tags.m
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Tags.h"


NSString *const kTagsId = @"id";
NSString *const kTagsName = @"name";


@interface Tags ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Tags

@synthesize tagsIdentifier = _tagsIdentifier;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.tagsIdentifier = [[self objectOrNilForKey:kTagsId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kTagsName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tagsIdentifier] forKey:kTagsId];
    [mutableDict setValue:self.name forKey:kTagsName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.tagsIdentifier = [aDecoder decodeDoubleForKey:kTagsId];
    self.name = [aDecoder decodeObjectForKey:kTagsName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_tagsIdentifier forKey:kTagsId];
    [aCoder encodeObject:_name forKey:kTagsName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Tags *copy = [[Tags alloc] init];
    
    if (copy) {

        copy.tagsIdentifier = self.tagsIdentifier;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
