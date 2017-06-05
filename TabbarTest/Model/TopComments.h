//
//  TopComments.h
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class U;

@interface TopComments : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double topCommentsIdentifier;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double hateCount;
@property (nonatomic, strong) NSString *passtime;
@property (nonatomic, assign) double voicetime;
@property (nonatomic, strong) NSString *cmtType;
@property (nonatomic, assign) double likeCount;
@property (nonatomic, strong) U *u;
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, assign) double preuid;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double precid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
