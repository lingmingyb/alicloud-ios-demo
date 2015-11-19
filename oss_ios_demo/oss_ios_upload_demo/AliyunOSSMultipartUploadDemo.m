//
//  AliyunOSSMultipartUploadDemo.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/18.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSMultipartUploadDemo.h"
#import "AliyunOSSCommonSupport.h"

extern NSString * const AccessKey;
extern NSString * const SecretKey;
extern NSString * const endPoint;

@implementation AliyunOSSMultipartUploadDemo

- (void)runDemo {
    // client init
    OSSClient * client;
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    __block NSString * uploadId = nil;
    __block NSMutableArray * partInfos = [NSMutableArray new];
    
    NSString * uploadToBucket = @"<enter your bucket name>";
    NSString * uploadObjectkey = @"<enter object key>";
    
    OSSInitMultipartUploadRequest * init = [OSSInitMultipartUploadRequest new];
    init.bucketName = uploadToBucket;
    init.objectKey = uploadObjectkey;
    init.contentType = @"application/octet-stream";
    init.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil];
    
    OSSTask * initTask = [client multipartUploadInit:init];
    
    [[initTask continueWithBlock:^id(OSSTask *task) {
        OSSUploadPartResult * result = task.result;
        if (!initTask.error) {
            OSSInitMultipartUploadResult * result = initTask.result;
            uploadId = result.uploadId;
            NSLog(@"init multipart upload success: %@", result.uploadId);
        } else {
            NSLog(@"multipart upload failed, error: %@", initTask.error);
        }
        return nil;
    }] waitUntilFinished];
    
    
    for (int i = 1; i <= 3; i++) {
        OSSUploadPartRequest * uploadPart = [OSSUploadPartRequest new];
        uploadPart.bucketName = uploadToBucket;
        uploadPart.objectkey = uploadObjectkey;
        uploadPart.uploadId = uploadId;
        uploadPart.partNumber = i; // part number start from 1
        
        // create temp file
        NSString * tempFilePath = [AliyunOSSCommonSupport createTempFile:@"temp_multipart_upload" fileSize:1024000];
        uploadPart.uploadPartFileURL = [NSURL URLWithString:tempFilePath];
        
        OSSTask * uploadPartTask = [client uploadPart:uploadPart];
        
        [[uploadPartTask continueWithBlock:^id(OSSTask *task) {
            if (!uploadPartTask.error) {
                OSSUploadPartResult * result = uploadPartTask.result;
                uint64_t fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:uploadPart.uploadPartFileURL.absoluteString error:nil] fileSize];
                [partInfos addObject:[OSSPartInfo partInfoWithPartNum:i eTag:result.eTag size:fileSize]];
            } else {
                NSLog(@"upload part error: %@", uploadPartTask.error);
            }
            return nil;
        }] waitUntilFinished];
        
    }
    
    OSSCompleteMultipartUploadRequest * complete = [OSSCompleteMultipartUploadRequest new];
    complete.bucketName = uploadToBucket;
    complete.objectKey = uploadObjectkey;
    complete.uploadId = uploadId;
    complete.partInfos = partInfos;
    
    OSSTask * completeTask = [client completeMultipartUpload:complete];
    
    [[completeTask continueWithBlock:^id(OSSTask *task) {
        if (!completeTask.error) {
            NSLog(@"multipart upload success!");
        } else {
            NSLog(@"multipart upload failed, error: %@", completeTask.error);
        }
        return nil;
    }] waitUntilFinished];
    
    // clear temp files
    [AliyunOSSCommonSupport clearAllTempFile];
    
}

@end