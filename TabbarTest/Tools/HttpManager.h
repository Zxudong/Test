//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HttpManager : NSObject

@property (nonatomic,strong)AFHTTPSessionManager *sessionManager;

@property (nonatomic,strong)AFNetworkReachabilityManager *reachabilityManager;

//单例
+ (HttpManager *)shareManager;

//获取当前网络状态
- (void)getNetWorkStatus;

//普通GET网络请求
- (void)getDataWithURL: (NSString *)urlStr
            parameters: (id)parameters
               success: (void(^)(id responseObject))success
               failure: (void(^)(NSError *error))failure;

//普通GET网络请求(progress)
- (void)getDataWithURL: (NSString *)urlStr
            parameters: (id)parameters
              progress: (void(^)(float value))progressValue
               success: (void(^)(id responseObject))success
               failure: (void(^)(NSError *error))failure;

//普通POST网络请求
- (void)postDataWithURL: (NSString *)urlStr
             parameters: (id)parameters
                success: (void(^)(id responseObject))success
                failure: (void(^)(NSError *error))failure;

//普通POST网络请求(progress)
- (void)postDataWithURL: (NSString *)urlStr
             parameters: (id)parameters
               progress: (void(^)(float value))progressValue
                success: (void(^)(id responseObject))success
                failure: (void(^)(NSError *error))failure;

//普通PUT网络请求
- (void)putDataWithURL: (NSString *)urlStr
            parameters: (id)parameters
               success: (void(^)(id responseObject))success
               failure: (void(^)(NSError *error))failure;

//普通delete网络请求
- (void)deleteDataWithURL: (NSString *)urlStr
               parameters: (id)parameters
                  success: (void(^)(id responseObject))success
                  failure: (void(^)(NSError *error))failure;

////普通download网络请求
//- (void)download;

//取消当前网络请求
- (void)cancel:(BOOL)isCancel;

+ (AFSecurityPolicy*)customSecurityPolicy;
+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data;

@end
