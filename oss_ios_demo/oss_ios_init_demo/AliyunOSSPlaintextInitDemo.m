//
//  AliyunOSSPlaintextInitDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/19.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSPlaintextInitDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSPlaintextInitDemo

- (void)runDemo {
    // client init with plaintext
    OSSClient * client;
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    // client init success or not
    if (client) {
        NSLog(@"client init success!");
    } else {
        NSLog(@"client init failed.");
    }
    
    // test client with simple uploading
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // create temp file
    NSString * tempFilePath = [AliyunOSSCommonSupport createTempFile:@"temp_plaintext_init" fileSize:1024];
    
    // required fields
    put.bucketName = @"<enter your bucket name>";
    put.objectKey = @"<enter object key>";
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