//
//  AliyunOSSScopeDownloadDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/18.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSScopeDownloadDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSScopeDownloadDemo

- (void)runDemo {
    // client init
    OSSClient * client;
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    request.bucketName = @"<enter your bucket name>";
    request.objectKey = @"<enter object key>";
    
    // specify the scope
    request.range = [[OSSRange alloc] initWithStart:1 withEnd:99]; // bytes=1-99
    
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    
    OSSTask * getTask = [client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"download object success!");
            OSSGetObjectResult * getResult = task.result;
            //NSLog(@"download result: %@", getResult.dowloadedData);
        } else {
            NSLog(@"download object failed, error: %@" ,task.error);
        }
        return nil;
    }];
}

@end