//
//  XDFileManager.m
//  Utils
//
//  Created by 赵旭东 on 2016/12/15.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import "XDFileManager.h"


@implementation XDFileManager


#pragma mark - 把对象归档存到沙盒里
+(void)saveObject:(id)object byFileName:(NSString*)fileName{

    
    NSString *path  = [self appendFilePath:fileName];
    
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}
#pragma mark - 通过文件名从沙盒中找到归档的对象
+(id)getObjectByFileName:(NSString*)fileName{

    NSString *path  = [self appendFilePath:fileName];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
#pragma mark - 根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*)fileName{
    NSString *path  = [self appendFilePath:fileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}
#pragma mark - 拼接文件路径(私有方法)
+(NSString*)appendFilePath:(NSString*)fileName{
    
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *file = [NSString stringWithFormat:@"%@/%@.archiver",documentsPath,fileName];
    
    return file;
}



#pragma mark - 存储用户偏好设置 到 NSUserDefults
+(void)saveUserDefaultsData:(id)data forKey:(NSString*)key{
    if (data){
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
#pragma mark - 读取用户偏好设置
+(id)readUserDefaultsDataForKey:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}
#pragma mark - 删除用户偏好设置
+(void)removeUserDefaultsDataForkey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
}


@end
