//
//  U.m
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "U.h"


NSString *const kURoomRole = @"room_role";
NSString *const kUUid = @"uid";
NSString *const kUHeader = @"header";
NSString *const kURoomUrl = @"room_url";
NSString *const kURoomName = @"room_name";
NSString *const kUIsVip = @"is_vip";
NSString *const kUIsV = @"is_v";
NSString *const kURoomIcon = @"room_icon";
NSString *const kUSex = @"sex";
NSString *const kUName = @"name";


@interface U ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation U

@synthesize roomRole = _roomRole;
@synthesize uid = _uid;
@synthesize header = _header;
@synthesize roomUrl = _roomUrl;
@synthesize roomName = _roomName;
@synthesize isVip = _isVip;
@synthesize isV = _isV;
@synthesize roomIcon = _roomIcon;
@synthesize sex = _sex;
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
            self.roomRole = [self objectOrNilForKey:kURoomRole fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kUUid fromDictionary:dict];
            self.header = [self objectOrNilForKey:kUHeader fromDictionary:dict];
            self.roomUrl = [self objectOrNilForKey:kURoomUrl fromDictionary:dict];
            self.roomName = [self objectOrNilForKey:kURoomName fromDictionary:dict];
            self.isVip = [[self objectOrNilForKey:kUIsVip fromDictionary:dict] boolValue];
            self.isV = [[self objectOrNilForKey:kUIsV fromDictionary:dict] boolValue];
            self.roomIcon = [self objectOrNilForKey:kURoomIcon fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kUSex fromDictionary:dict];
            self.name = [self objectOrNilForKey:kUName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.roomRole forKey:kURoomRole];
    [mutableDict setValue:self.uid forKey:kUUid];
    NSMutableArray *tempArrayForHeader = [NSMutableArray array];
    for (NSObject *subArrayObject in self.header) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHeader addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHeader addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHeader] forKey:kUHeader];
    [mutableDict setValue:self.roomUrl forKey:kURoomUrl];
    [mutableDict setValue:self.roomName forKey:kURoomName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isVip] forKey:kUIsVip];
    [mutableDict setValue:[NSNumber numberWithBool:self.isV] forKey:kUIsV];
    [mutableDict setValue:self.roomIcon forKey:kURoomIcon];
    [mutableDict setValue:self.sex forKey:kUSex];
    [mutableDict setValue:self.name forKey:kUName];

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

    self.roomRole = [aDecoder decodeObjectForKey:kURoomRole];
    self.uid = [aDecoder decodeObjectForKey:kUUid];
    self.header = [aDecoder decodeObjectForKey:kUHeader];
    self.roomUrl = [aDecoder decodeObjectForKey:kURoomUrl];
    self.roomName = [aDecoder decodeObjectForKey:kURoomName];
    self.isVip = [aDecoder decodeBoolForKey:kUIsVip];
    self.isV = [aDecoder decodeBoolForKey:kUIsV];
    self.roomIcon = [aDecoder decodeObjectForKey:kURoomIcon];
    self.sex = [aDecoder decodeObjectForKey:kUSex];
    self.name = [aDecoder decodeObjectForKey:kUName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_roomRole forKey:kURoomRole];
    [aCoder encodeObject:_uid forKey:kUUid];
    [aCoder encodeObject:_header forKey:kUHeader];
    [aCoder encodeObject:_roomUrl forKey:kURoomUrl];
    [aCoder encodeObject:_roomName forKey:kURoomName];
    [aCoder encodeBool:_isVip forKey:kUIsVip];
    [aCoder encodeBool:_isV forKey:kUIsV];
    [aCoder encodeObject:_roomIcon forKey:kURoomIcon];
    [aCoder encodeObject:_sex forKey:kUSex];
    [aCoder encodeObject:_name forKey:kUName];
}

- (id)copyWithZone:(NSZone *)zone
{
    U *copy = [[U alloc] init];
    
    if (copy) {

        copy.roomRole = [self.roomRole copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.header = [self.header copyWithZone:zone];
        copy.roomUrl = [self.roomUrl copyWithZone:zone];
        copy.roomName = [self.roomName copyWithZone:zone];
        copy.isVip = self.isVip;
        copy.isV = self.isV;
        copy.roomIcon = [self.roomIcon copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
