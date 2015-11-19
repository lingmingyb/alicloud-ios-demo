//
//  AliyunOSSMD5UploadDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/18.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSMD5UploadDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSMD5UploadDemo

- (void)runDemo {
    // client init
    OSSClient * client;
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    // simple asynchronous upload
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    OSSPutObjectRequest * request = [OSSPutObjectRequest new];
    request.bucketName = @"junmo";
    request.objectKey = @"file_md5_upload";
    
    
    NSString * tempFilePath = [AliyunOSSCommonSupport createTempFile:@"temp_md5_upload" fileSize:1024];
    NSURL * tempFileURL = [NSURL fileURLWithPath:tempFilePath];
    
    NSFileHandle * readFile = [NSFileHandle fileHandleForReadingFromURL:tempFileURL error:nil];
    
    request.uploadingData = [readFile readDataToEndOfFile];
    request.contentMd5 = [OSSUtil base64Md5ForData:request.uploadingData];
    request.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil];
    request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    
    OSSTask * task = [client putObject:request];
    [[task continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            OSSLogError(@"%@", task.error);
        }
        OSSPutObjectResult * result = task.result;
        NSLog(@"Result - requestId: %@, headerFields: %@",
              result.requestId,
              result.httpResponseHeaderFields);
        NSLog(@"MD5 upload success!");
        return nil;
    }] waitUntilFinished];
}

@end