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
    
    [self runOSSPlaintextInitDemo];
    //[self runOSSCustomInitDemo];
    //[self runOSSSTSInitDemo];
    
    //[self runOSSSimpleUploadDemo];
    //[self runOSSAppendUploadDemo];
    //[self runOSSMultipartUploadDemo];
    //[self runOSSMD5UploadDemo];
    
    //[self runOSSSimpleDownloadDemo];
    //[self runOSSScopeDownloadDemo];
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