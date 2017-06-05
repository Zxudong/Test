//
//  U.h
//
//  Created by   on 2017/1/10
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface U : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *roomRole;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSArray *header;
@property (nonatomic, strong) NSString *roomUrl;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, assign) BOOL isVip;
@property (nonatomic, assign) BOOL isV;
@property (nonatomic, strong) NSString *roomIcon;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
