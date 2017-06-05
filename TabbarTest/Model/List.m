//
//  List.m
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "List.h"
#import "Video.h"
#import "Tags.h"
#import "U.h"
#import "TopComments.h"


NSString *const kListId = @"id";
NSString *const kListUp = @"up";
NSString *const kListVideo = @"video";
NSString *const kListPasstime = @"passtime";
NSString *const kListTags = @"tags";
NSString *const kListType = @"type";
NSString *const kListComment = @"comment";
NSString *const kListDown = @"down";
NSString *const kListText = @"text";
NSString *const kListShareUrl = @"share_url";
NSString *const kListU = @"u";
NSString *const kListForward = @"forward";
NSString *const kListTopComments = @"top_comments";
NSString *const kListBookmark = @"bookmark";
NSString *const kListStatus = @"status";


@interface List ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation List

@synthesize listIdentifier = _listIdentifier;
@synthesize up = _up;
@synthesize video = _video;
@synthesize passtime = _passtime;
@synthesize tags = _tags;
@synthesize type = _type;
@synthesize comment = _comment;
@synthesize down = _down;
@synthesize text = _text;
@synthesize shareUrl = _shareUrl;
@synthesize u = _u;
@synthesize forward = _forward;
@synthesize topComments = _topComments;
@synthesize bookmark = _bookmark;
@synthesize status = _status;


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
            self.listIdentifier = [self objectOrNilForKey:kListId fromDictionary:dict];
            self.up = [self objectOrNilForKey:kListUp fromDictionary:dict];
            self.video = [Video modelObjectWithDictionary:[dict objectForKey:kListVideo]];
            self.passtime = [self objectOrNilForKey:kListPasstime fromDictionary:dict];
    NSObject *receivedTags = [dict objectForKey:kListTags];
    NSMutableArray *parsedTags = [NSMutableArray array];
    if ([receivedTags isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTags) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTags addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTags isKindOfClass:[NSDictionary class]]) {
       [parsedTags addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTags]];
    }

    self.tags = [NSArray arrayWithArray:parsedTags];
            self.type = [self objectOrNilForKey:kListType fromDictionary:dict];
            self.comment = [self objectOrNilForKey:kListComment fromDictionary:dict];
            self.down = [[self objectOrNilForKey:kListDown fromDictionary:dict] doubleValue];
            self.text = [self objectOrNilForKey:kListText fromDictionary:dict];
            self.shareUrl = [self objectOrNilForKey:kListShareUrl fromDictionary:dict];
            self.u = [U modelObjectWithDictionary:[dict objectForKey:kListU]];
            self.forward = [[self objectOrNilForKey:kListForward fromDictionary:dict] doubleValue];
    NSObject *receivedTopComments = [dict objectForKey:kListTopComments];
    NSMutableArray *parsedTopComments = [NSMutableArray array];
    if ([receivedTopComments isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTopComments) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTopComments addObject:[TopComments modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTopComments isKindOfClass:[NSDictionary class]]) {
       [parsedTopComments addObject:[TopComments modelObjectWithDictionary:(NSDictionary *)receivedTopComments]];
    }

    self.topComments = [NSArray arrayWithArray:parsedTopComments];
            self.bookmark = [self objectOrNilForKey:kListBookmark fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kListStatus fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.listIdentifier forKey:kListId];
    [mutableDict setValue:self.up forKey:kListUp];
    [mutableDict setValue:[self.video dictionaryRepresentation] forKey:kListVideo];
    [mutableDict setValue:self.passtime forKey:kListPasstime];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kListTags];
    [mutableDict setValue:self.type forKey:kListType];
    [mutableDict setValue:self.comment forKey:kListComment];
    [mutableDict setValue:[NSNumber numberWithDouble:self.down] forKey:kListDown];
    [mutableDict setValue:self.text forKey:kListText];
    [mutableDict setValue:self.shareUrl forKey:kListShareUrl];
    [mutableDict setValue:[self.u dictionaryRepresentation] forKey:kListU];
    [mutableDict setValue:[NSNumber numberWithDouble:self.forward] forKey:kListForward];
    NSMutableArray *tempArrayForTopComments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.topComments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTopComments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTopComments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTopComments] forKey:kListTopComments];
    [mutableDict setValue:self.bookmark forKey:kListBookmark];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kListStatus];

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

    self.listIdentifier = [aDecoder decodeObjectForKey:kListId];
    self.up = [aDecoder decodeObjectForKey:kListUp];
    self.video = [aDecoder decodeObjectForKey:kListVideo];
    self.passtime = [aDecoder decodeObjectForKey:kListPasstime];
    self.tags = [aDecoder decodeObjectForKey:kListTags];
    self.type = [aDecoder decodeObjectForKey:kListType];
    self.comment = [aDecoder decodeObjectForKey:kListComment];
    self.down = [aDecoder decodeDoubleForKey:kListDown];
    self.text = [aDecoder decodeObjectForKey:kListText];
    self.shareUrl = [aDecoder decodeObjectForKey:kListShareUrl];
    self.u = [aDecoder decodeObjectForKey:kListU];
    self.forward = [aDecoder decodeDoubleForKey:kListForward];
    self.topComments = [aDecoder decodeObjectForKey:kListTopComments];
    self.bookmark = [aDecoder decodeObjectForKey:kListBookmark];
    self.status = [aDecoder decodeDoubleForKey:kListStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_listIdentifier forKey:kListId];
    [aCoder encodeObject:_up forKey:kListUp];
    [aCoder encodeObject:_video forKey:kListVideo];
    [aCoder encodeObject:_passtime forKey:kListPasstime];
    [aCoder encodeObject:_tags forKey:kListTags];
    [aCoder encodeObject:_type forKey:kListType];
    [aCoder encodeObject:_comment forKey:kListComment];
    [aCoder encodeDouble:_down forKey:kListDown];
    [aCoder encodeObject:_text forKey:kListText];
    [aCoder encodeObject:_shareUrl forKey:kListShareUrl];
    [aCoder encodeObject:_u forKey:kListU];
    [aCoder encodeDouble:_forward forKey:kListForward];
    [aCoder encodeObject:_topComments forKey:kListTopComments];
    [aCoder encodeObject:_bookmark forKey:kListBookmark];
    [aCoder encodeDouble:_status forKey:kListStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    List *copy = [[List alloc] init];
    
    if (copy) {

        copy.listIdentifier = [self.listIdentifier copyWithZone:zone];
        copy.up = [self.up copyWithZone:zone];
        copy.video = [self.video copyWithZone:zone];
        copy.passtime = [self.passtime copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.down = self.down;
        copy.text = [self.text copyWithZone:zone];
        copy.shareUrl = [self.shareUrl copyWithZone:zone];
        copy.u = [self.u copyWithZone:zone];
        copy.forward = self.forward;
        copy.topComments = [self.topComments copyWithZone:zone];
        copy.bookmark = [self.bookmark copyWithZone:zone];
        copy.status = self.status;
    }
    
    return copy;
}


@end
