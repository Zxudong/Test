//
//  NSDictionary+Edit.m
//  TabbarTest
//
//  Created by 赵旭东 on 2017/3/29.
//  Copyright © 2017年 赵旭东. All rights reserved.
//

#import "NSDictionary+Edit.h"
#import "XD_Tools.h"

@implementation NSDictionary (Edit)

-(NSString *)safeNullWithKey:(NSString *)key{
    
    return checkNull([self objectForKey:key]);;
    
}

@end
