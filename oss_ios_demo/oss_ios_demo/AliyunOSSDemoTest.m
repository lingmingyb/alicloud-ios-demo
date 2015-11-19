//
//  AliyunOSSDemoTest.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/19.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import "AliyunOSSDemoTest.h"

@implementation AliyunOSSDemoTest

- (void)selectDemoToRun {
    
    /** 明文设置初始化client并简单上传 */
    [self runOSSPlaintextInitDemo];
    
    /** 自签名初始化client并简单上传 */
    //[self runOSSCustomInitDemo];
    
    /** Federation鉴权初始化client并简单上传 */
    //[self runOSSSTSInitDemo];
    
    /** 简单上传 */
    //[self runOSSSimpleUploadDemo];
    
    /** 追加上传 */
    //[self runOSSAppendUploadDemo];
    
    /** 断点续传 */
    //[self runOSSMultipartUploadDemo];
    
    /** MD5校验上传 */
    //[self runOSSMD5UploadDemo];
    
    /** 简单下载 */
    //[self runOSSSimpleDownloadDemo];
    
    /** 指定范围下载 */
    //[self runOSSScopeDownloadDemo];
    
    /** 只获取文件元数据 */
    //[self runOSSSHeaderDownloadDemo];
}

// init
- (void)runOSSPlaintextInitDemo {
    AliyunOSSPlaintextInitDemo * demo = [[AliyunOSSPlaintextInitDemo alloc] init];
    [demo runDemo];
}
- (void)runOSSCustomInitDemo {
    AliyunOSSCustomInitDemo * demo = [[AliyunOSSCustomInitDemo alloc] init];
    [demo runDemo];
}
- (void)runOSSSTSInitDemo {
    AliyunOSSSTSInitDemo * demo = [[AliyunOSSSTSInitDemo alloc] init];
    [demo runDemo];
}

// upload
- (void)runOSSSimpleUploadDemo {
    AliyunOSSSimpleUploadDemo * demo = [[AliyunOSSSimpleUploadDemo alloc] init];
    [demo runDemo];
}
- (void)runOSSAppendUploadDemo {
    AliyunOSSAppendUploadDemo * demo = [[AliyunOSSAppendUploadDemo alloc] init];
    [demo runDemo];
}
- (void)runOSSMultipartUploadDemo {
    AliyunOSSMultipartUploadDemo * demo = [[AliyunOSSMultipartUploadDemo alloc] init];
    [demo runDemo];
}
- (void)runOSSMD5UploadDemo {
    AliyunOSSMD5UploadDemo * demo = [[AliyunOSSMD5UploadDemo alloc] init];
    [demo runDemo];
}


// download
- (void) runOSSSimpleDownloadDemo {
    AliyunOSSSimpleDownloadDemo * demo = [[AliyunOSSSimpleDownloadDemo alloc] init];
    [demo runDemo];
}
- (void) runOSSScopeDownloadDemo {
    AliyunOSSScopeDownloadDemo * demo = [[AliyunOSSScopeDownloadDemo alloc] init];
    [demo runDemo];
}
- (void) runOSSSHeaderDownloadDemo {
    AliyunOSSHeaderDownloadDemo * demo = [[AliyunOSSHeaderDownloadDemo alloc] init];
    [demo runDemo];
}

@end