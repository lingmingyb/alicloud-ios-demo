//
//  AliyunOSSDownloadWithBlockDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/19.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSDownloadWithBlockDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSDownloadWithBlockDemo

- (void)runDemo {
    // client init
    OSSClient * client;
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    
    request.bucketName = @"<enter your bucket name>";
    request.objectKey = @"<enter object key>";
    
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    // during download process, call back the block when receiving a piece of data
    request.onRecieveData = ^(NSData * data) {
        NSLog(@"onRecieveData: %lu", [data length]);
    };
    
    OSSTask * task = [client getObject:request];
    
    [[task continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            NSLog(@"download object failed, error:%@", task.error);
        } else {
            NSLog(@"download object success!");
            OSSGetObjectResult * result = task.result;
            NSAssert(200 == result.httpResponseCode, @"");
            // if onRecieveData is setting, it will not return whole data
            NSAssert(0 == [result.downloadedData length], @"");

            NSLog(@"Result - requestId: %@, headerFields: %@, dataLength: %lu",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  (unsigned long)[result.downloadedData length]);
        }
        return nil;
    }] waitUntilFinished];

}

@end