//
//  TopComments.m
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "TopComments.h"
#import "U.h"


NSString *const kTopCommentsId = @"id";
NSString *const kTopCommentsContent = @"content";
NSString *const kTopCommentsHateCount = @"hate_count";
NSString *const kTopCommentsPasstime = @"passtime";
NSString *const kTopCommentsVoicetime = @"voicetime";
NSString *const kTopCommentsCmtType = @"cmt_type";
NSString *const kTopCommentsLikeCount = @"like_count";
NSString *const kTopCommentsU = @"u";
NSString *const kTopCommentsVoiceuri = @"voiceuri";
NSString *const kTopCommentsPreuid = @"preuid";
NSString *const kTopCommentsStatus = @"status";
NSString *const kTopCommentsPrecid = @"precid";


@interface TopComments ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TopComments

@synthesize topCommentsIdentifier = _topCommentsIdentifier;
@synthesize content = _content;
@synthesize hateCount = _hateCount;
@synthesize passtime = _passtime;
@synthesize voicetime = _voicetime;
@synthesize cmtType = _cmtType;
@synthesize likeCount = _likeCount;
@synthesize u = _u;
@synthesize voiceuri = _voiceuri;
@synthesize preuid = _preuid;
@synthesize status = _status;
@synthesize precid = _precid;


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
            self.topCommentsIdentifier = [[self objectOrNilForKey:kTopCommentsId fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kTopCommentsContent fromDictionary:dict];
            self.hateCount = [[self objectOrNilForKey:kTopCommentsHateCount fromDictionary:dict] doubleValue];
            self.passtime = [self objectOrNilForKey:kTopCommentsPasstime fromDictionary:dict];
            self.voicetime = [[self objectOrNilForKey:kTopCommentsVoicetime fromDictionary:dict] doubleValue];
            self.cmtType = [self objectOrNilForKey:kTopCommentsCmtType fromDictionary:dict];
            self.likeCount = [[self objectOrNilForKey:kTopCommentsLikeCount fromDictionary:dict] doubleValue];
            self.u = [U modelObjectWithDictionary:[dict objectForKey:kTopCommentsU]];
            self.voiceuri = [self objectOrNilForKey:kTopCommentsVoiceuri fromDictionary:dict];
            self.preuid = [[self objectOrNilForKey:kTopCommentsPreuid fromDictionary:dict] doubleValue];
            self.status = [[self objectOrNilForKey:kTopCommentsStatus fromDictionary:dict] doubleValue];
            self.precid = [[self objectOrNilForKey:kTopCommentsPrecid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.topCommentsIdentifier] forKey:kTopCommentsId];
    [mutableDict setValue:self.content forKey:kTopCommentsContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hateCount] forKey:kTopCommentsHateCount];
    [mutableDict setValue:self.passtime forKey:kTopCommentsPasstime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.voicetime] forKey:kTopCommentsVoicetime];
    [mutableDict setValue:self.cmtType forKey:kTopCommentsCmtType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.likeCount] forKey:kTopCommentsLikeCount];
    [mutableDict setValue:[self.u dictionaryRepresentation] forKey:kTopCommentsU];
    [mutableDict setValue:self.voiceuri forKey:kTopCommentsVoiceuri];
    [mutableDict setValue:[NSNumber numberWithDouble:self.preuid] forKey:kTopCommentsPreuid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kTopCommentsStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.precid] forKey:kTopCommentsPrecid];

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

    self.topCommentsIdentifier = [aDecoder decodeDoubleForKey:kTopCommentsId];
    self.content = [aDecoder decodeObjectForKey:kTopCommentsContent];
    self.hateCount = [aDecoder decodeDoubleForKey:kTopCommentsHateCount];
    self.passtime = [aDecoder decodeObjectForKey:kTopCommentsPasstime];
    self.voicetime = [aDecoder decodeDoubleForKey:kTopCommentsVoicetime];
    self.cmtType = [aDecoder decodeObjectForKey:kTopCommentsCmtType];
    self.likeCount = [aDecoder decodeDoubleForKey:kTopCommentsLikeCount];
    self.u = [aDecoder decodeObjectForKey:kTopCommentsU];
    self.voiceuri = [aDecoder decodeObjectForKey:kTopCommentsVoiceuri];
    self.preuid = [aDecoder decodeDoubleForKey:kTopCommentsPreuid];
    self.status = [aDecoder decodeDoubleForKey:kTopCommentsStatus];
    self.precid = [aDecoder decodeDoubleForKey:kTopCommentsPrecid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_topCommentsIdentifier forKey:kTopCommentsId];
    [aCoder encodeObject:_content forKey:kTopCommentsContent];
    [aCoder encodeDouble:_hateCount forKey:kTopCommentsHateCount];
    [aCoder encodeObject:_passtime forKey:kTopCommentsPasstime];
    [aCoder encodeDouble:_voicetime forKey:kTopCommentsVoicetime];
    [aCoder encodeObject:_cmtType forKey:kTopCommentsCmtType];
    [aCoder encodeDouble:_likeCount forKey:kTopCommentsLikeCount];
    [aCoder encodeObject:_u forKey:kTopCommentsU];
    [aCoder encodeObject:_voiceuri forKey:kTopCommentsVoiceuri];
    [aCoder encodeDouble:_preuid forKey:kTopCommentsPreuid];
    [aCoder encodeDouble:_status forKey:kTopCommentsStatus];
    [aCoder encodeDouble:_precid forKey:kTopCommentsPrecid];
}

- (id)copyWithZone:(NSZone *)zone
{
    TopComments *copy = [[TopComments alloc] init];
    
    if (copy) {

        copy.topCommentsIdentifier = self.topCommentsIdentifier;
        copy.content = [self.content copyWithZone:zone];
        copy.hateCount = self.hateCount;
        copy.passtime = [self.passtime copyWithZone:zone];
        copy.voicetime = self.voicetime;
        copy.cmtType = [self.cmtType copyWithZone:zone];
        copy.likeCount = self.likeCount;
        copy.u = [self.u copyWithZone:zone];
        copy.voiceuri = [self.voiceuri copyWithZone:zone];
        copy.preuid = self.preuid;
        copy.status = self.status;
        copy.precid = self.precid;
    }
    
    return copy;
}


@end
