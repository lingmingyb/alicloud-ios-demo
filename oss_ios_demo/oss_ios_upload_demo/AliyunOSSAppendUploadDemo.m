//
//  AliyunOSSAppendUploadDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/18.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSAppendUploadDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSAppendUploadDemo

- (void)runDemo {
    // client init
    OSSClient * client;
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    
    OSSAppendObjectRequest * append = [OSSAppendObjectRequest new];
    
    // 必填字段
    append.bucketName = @"junmo";
    append.objectKey = @"file_append_upload";
    append.appendPosition = 0; // 指定从何处进行追加
    // create temp file
    NSString * tempFilePath = [AliyunOSSCommonSupport createTempFile:@"temp_append_upload" fileSize:1024];
    append.uploadingFileURL = [NSURL fileURLWithPath:tempFilePath];
    
    // 可选字段
    append.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    append.contentType = @"";
    append.contentMd5 = @"";
    append.contentEncoding = @"";
    append.contentDisposition = @"";
    
    OSSTask * appendTask = [client appendObject:append];
    
    [[appendTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", append.objectKey);
        if (!task.error) {
            NSLog(@"append object success!");
            OSSAppendObjectResult * result = task.result;
            NSString * etag = result.eTag;
            long nextPosition = result.xOssNextAppendPosition;
        } else {
            NSLog(@"append object failed, error: %@" , task.error);
        }
        return nil;
    }] waitUntilFinished];
    // clear temp files
    [AliyunOSSCommonSupport clearAllTempFile];
}

@end