//
//  Video.h
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Video : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *thumbnail;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSArray *download;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double playfcount;
@property (nonatomic, assign) double duration;
@property (nonatomic, strong) NSArray *thumbnailSmall;
@property (nonatomic, strong) NSArray *video;
@property (nonatomic, assign) double playcount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
