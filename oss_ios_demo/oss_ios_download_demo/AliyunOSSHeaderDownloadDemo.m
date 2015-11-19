//
//  AliyunOSSHeaderDownloadDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/18.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSHeaderDownloadDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSHeaderDownloadDemo

- (void)runDemo {
    // client init
    OSSClient * client;
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    OSSHeadObjectRequest * request = [OSSHeadObjectRequest new];
    request.bucketName = @"junmo";
    request.objectKey = @"file_simple_upload";
    
    OSSTask * headTask = [client headObject:request];
    
    [headTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"head object success!");
            OSSHeadObjectResult * result = task.result;
            NSLog(@"header fields: %@", result.httpResponseHeaderFields);
            for (NSString * key in result.objectMeta) {
                NSLog(@"ObjectMeta: %@ - %@", key, [result.objectMeta objectForKey:key]);
            }
        } else {
            NSLog(@"head object failed, error: %@" ,task.error);
        }
        return nil;
    }];
}
@end