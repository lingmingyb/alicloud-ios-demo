//
//  AliyunOSSCustomInitDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/19.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSCustomInitDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSCustomInitDemo

- (void)runDemo {
    // client init with custom signer
    OSSClient * client;
    
    id<OSSCredentialProvider> credential = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
        NSString *signature = [OSSUtil calBase64Sha1WithData:contentToSign withSecret:SecretKey];
        if (signature != nil) {
            *error = nil;
            NSLog(@"custom signer client init success!");
        } else {
            // construct error object
            *error = [NSError errorWithDomain:@"<your error domain>" code:OSSClientErrorCodeSignFailed userInfo:nil];
            return nil;
        }
        return [NSString stringWithFormat:@"OSS %@:%@", AccessKey, signature];
    }];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    if (client) {
        NSLog(@"client init success!");
    } else {
        NSLog(@"client init failed.");
    }
    
    // test client with simple uploading
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // create temp file
    NSString * tempFilePath = [AliyunOSSCommonSupport createTempFile:@"temp_customsigner_init" fileSize:1024];
    
    // required fields
    put.bucketName = @"junmo";
    put.objectKey = @"file_customsigner_init";
    
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
