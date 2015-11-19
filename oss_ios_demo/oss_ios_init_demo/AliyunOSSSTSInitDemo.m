//
//  AliyunOSSSTSInitDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/19.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSSTSInitDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * endPoint;

@implementation AliyunOSSSTSInitDemo

- (void)runDemo {
    
    OSSClient * client;
    
    // Federation鉴权，建议通过访问远程业务服务器获取签名
    // 假设访问业务服务器的获取token服务时，返回的数据格式如下：
    // {"accessKeyId":"STS.iA645eTOXEqP3cg3VeHf",
    // "accessKeySecret":"rV3VQrpFQ4BsyHSAvi5NVLpPIVffDJv4LojUBZCf",
    // "expiration":"2015-11-03T09:52:59Z[;",
    // "federatedUser":"335450541522398178:alice-001",
    // "requestId":"C0E01B94-332E-4582-87F9-B857C807EE52",
    // "securityToken":"CAES7QIIARKAAZPlqaN9ILiQZPS+JDkS/GSZN45RLx4YS/p3OgaUC+oJl3XSlbJ7StKpQp1Q3KtZVCeAKAYY6HYSFOa6rU0bltFXAPyW+jvlijGKLezJs0AcIvP5a4ki6yHWovkbPYNnFSOhOmCGMmXKIkhrRSHMGYJRj8AIUvICAbDhzryeNHvUGhhTVFMuaUE2NDVlVE9YRXFQM2NnM1ZlSGYiEjMzNTQ1MDU0MTUyMjM5ODE3OCoJYWxpY2UtMDAxMOG/g7v6KToGUnNhTUQ1QloKATEaVQoFQWxsb3cSHwoMQWN0aW9uRXF1YWxzEgZBY3Rpb24aBwoFb3NzOioSKwoOUmVzb3VyY2VFcXVhbHMSCFJlc291cmNlGg8KDWFjczpvc3M6KjoqOipKEDEwNzI2MDc4NDc4NjM4ODhSAFoPQXNzdW1lZFJvbGVVc2VyYABqEjMzNTQ1MDU0MTUyMjM5ODE3OHIHeHljLTAwMQ=="}
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        NSURL * url = [NSURL URLWithString:@"http://localhost:8080/distribute-token.json"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionTask * sessionTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (error) {
                                                            [tcs setError:error];
                                                            return;
                                                        }
                                                        [tcs setResult:data];
                                                    }];
        [sessionTask resume];
        [tcs.task waitUntilFinished];
        if (tcs.task.error) {
            return nil;
        } else {
            NSDictionary * object = [NSJSONSerialization JSONObjectWithData:tcs.task.result
                                                                    options:kNilOptions
                                                                      error:nil];
            OSSFederationToken * token = [OSSFederationToken new];
            // 四个值缺一不可
            token.tAccessKey = [object objectForKey:@"accessKeyId"];
            token.tSecretKey = [object objectForKey:@"accessKeySecret"];
            token.tToken = [object objectForKey:@"securityToken"];
            token.expirationTimeInGMTFormat = [object objectForKey:@"expiration"];
            return token;
        }
    }];
    
    
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
    
    if (client) {
        NSLog(@"client init success!");
    } else {
        NSLog(@"client init failed.");
    }
    
    // test client with simple uploading
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // create temp file
    NSString * tempFilePath = [AliyunOSSCommonSupport createTempFile:@"temp_sts_init" fileSize:1024];
    
    // required fields
    put.bucketName = @"junmo";
    put.objectKey = @"file_sts_init";
    
    put.uploadingFileURL = [NSURL fileURLWithPath:tempFilePath];
    
    // optional fields
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    put.contentType = @"";
    put.contentMd5 = @"";
    put.contentEncoding = @"";
    put.contentDisposition = @"";
    
    OSSTask * putTask = [client putObject:put];
    
    [[putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        
        // clear temp file
        [AliyunOSSCommonSupport clearAllTempFile];
        
        return nil;
    }] waitUntilFinished];
    

}

@end