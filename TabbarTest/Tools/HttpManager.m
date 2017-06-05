
#import "HttpManager.h"
#import "AFHTTPSessionManager.h"
#import "XD_Tools.h"

#define OnLineP12Name @"client"
#define OnLineP12Pwd @"123456"


#define BaseURL @"https://192.168.54.67:443/app-wz/personal/cs/cs.service"



static HttpManager *manager = nil;

//static AFHTTPSessionManager *sessionManager = nil;

@implementation HttpManager

+ (HttpManager *)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[HttpManager alloc]init];
        
        [manager sessionManagerInit];
        
        [manager reachabilityManagerInit];
        
    });
    
    return manager;
    
}

- (void)reachabilityManagerInit {
    
    //初始化网络监测对象
    _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
}

/**
 *  GET请求数据
 *
 *  @param urlStr     URL
 *  @param parameters BODY
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)getDataWithURL:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    
    [_sessionManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
        [self getFailureInfo:error];
        
    }];
    
}

- (void)getDataWithURL:(NSString *)urlStr parameters:(id)parameters progress:(void (^)(float))progressValue success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    
    [_sessionManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
        [self getFailureInfo:error];
        
    }];
    
}

/**
 *  POST请求数据
 *
 *  @param urlStr     URL
 *  @param parameters BODY
 *  @param success    成功返回数据
 *  @param failure    失败返回数据
 */
- (void)postDataWithURL:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    
    [_sessionManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
        [self getFailureInfo:error];
        
    }];
    
}

- (void)postDataWithURL:(NSString *)urlStr parameters:(id)parameters progress:(void (^)(float))progressValue success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    
    [_sessionManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
        [self getFailureInfo:error];
        
    }];
    
}

/**
 *  PUT网络请求
 *
 *  @param urlStr     URL
 *  @param parameters BODY
 *  @param success    success block
 *  @param failure    failure block
 */
- (void)putDataWithURL:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    
    [_sessionManager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
        [self getFailureInfo:error];
        
    }];
    
}

/**
 *  delete网络请求
 *
 *  @param urlStr     URL
 *  @param parameters BODY
 *  @param success    success block
 *  @param failure    failure block
 */
- (void)deleteDataWithURL:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,urlStr];
    
    [_sessionManager DELETE:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
        [self getFailureInfo:error];
        
    }];
    
}

- (void)getFailureInfo: (NSError *)error {
    
    if (error) {
        
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        
        if (data) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *mess = dictionary[@"message"];
            
            [SVProgressHUD showErrorWithStatus:mess];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            
        }
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"网络请求超时"];
        
    }
    
}

- (void)cancel:(BOOL)isCancel {
    
    
    
}

//获取当前网络状态
-(void)getNetWorkStatus{
    
    [_reachabilityManager startMonitoring];

    [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
    
            case AFNetworkReachabilityStatusReachableViaWiFi:  // 局域网络,不花钱
                NSLog(@"WIFI");
                break;

            case AFNetworkReachabilityStatusReachableViaWWAN:  //2G,3G,4G 花钱
                NSLog(@"自带网络");
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:    // 无连接
                NSLog(@"没有网络");
                break;
 
            default:
                break;
        }
    }];
    // 停止检测
    [_reachabilityManager stopMonitoring];
}




















/**
 *  HTTPS SSL 双向认证
 */
//manager 初始化
- (void)sessionManagerInit {
    
    //初始化
    _sessionManager = [AFHTTPSessionManager manager];
    
    //******************
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //******************
    
    //设置请求超时
    [_sessionManager.requestSerializer setTimeoutInterval:45.0f];
    
    [_sessionManager setSecurityPolicy:[HttpManager customSecurityPolicy]];
    __weak typeof(self)weakSelf = self;
    [_sessionManager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential =nil;
        
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if([weakSelf.sessionManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:OnLineP12Name ofType:@"p12"];//
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12])
            {
                NSLog(@"client.p12:not exist");
            }
            else
            {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                
                if ([HttpManager extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
    
}

//校验服务端证书
+ (AFSecurityPolicy*)customSecurityPolicy {
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server.der" ofType:nil];
    
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    securityPolicy.allowInvalidCertificates = YES;
    
    securityPolicy.validatesDomainName = YES;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    return securityPolicy;
    
}

//校验客户端证书
+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:OnLineP12Pwd
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

@end
