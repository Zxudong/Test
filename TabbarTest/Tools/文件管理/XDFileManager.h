//
//  XDFileManager.h
//  Utils
//
//  Created by 赵旭东 on 2016/12/15.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 文件管理类
@interface XDFileManager : NSObject

/*把对象归档存到沙盒里*/
+(void)saveObject:(id)object byFileName:(NSString*)fileName;
/*通过文件名从沙盒中找到归档的对象*/
+(id)getObjectByFileName:(NSString*)fileName;
/*根据文件名删除沙盒中的 plist 文件*/
+(void)removeFileByFileName:(NSString*)fileName;


/*存储用户偏好设置 到 NSUserDefults*/
+(void)saveUserDefaultsData:(id)data forKey:(NSString*)key;
/*读取用户偏好设置*/
+(id)readUserDefaultsDataForKey:(NSString*)key;
/*删除用户偏好设置*/
+(void)removeUserDefaultsDataForkey:(NSString*)key;

@end
