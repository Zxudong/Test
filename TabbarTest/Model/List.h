//
//  List.h
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Video, U;

@interface List : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *listIdentifier;
@property (nonatomic, strong) NSString *up;
@property (nonatomic, strong) Video *video;
@property (nonatomic, strong) NSString *passtime;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, assign) double down;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) U *u;
@property (nonatomic, assign) double forward;
@property (nonatomic, strong) NSArray *topComments;
@property (nonatomic, strong) NSString *bookmark;
@property (nonatomic, assign) double status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
