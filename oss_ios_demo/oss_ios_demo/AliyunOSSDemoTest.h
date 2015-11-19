//
//  AliyunOSSDemoTest.h
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/19.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#ifndef AliyunOSSDemoTest_h
#define AliyunOSSDemoTest_h
#import <Foundation/Foundation.h>

// common support
#import "AliyunOSSCommonSupport.h"

// init
#import "AliyunOSSPlaintextInitDemo.h"
#import "AliyunOSSCustomInitDemo.h"
#import "AliyunOSSSTSInitDemo.h"

// upload
#import "AliyunOSSSimpleUploadDemo.h"
#import "AliyunOSSAppendUploadDemo.h"
#import "AliyunOSSMultipartUploadDemo.h"
#import "AliyunOSSMD5UploadDemo.h"

// download
#import "AliyunOSSSimpleDownloadDemo.h"
#import "AliyunOSSScopeDownloadDemo.h"
#import "AliyunOSSHeaderDownloadDemo.h"
#import "AliyunOSSDownloadWithBlockDemo.h"

@interface AliyunOSSDemoTest : NSObject

- (void)selectDemoToRun;

// init
- (void)runOSSPlaintextInitDemo;
- (void)runOSSCustomInitDemo;
- (void)runOSSSTSInitDemo;

// upload
- (void)runOSSSimpleUploadDemo;
- (void)runOSSAppendUploadDemo;
- (void)runOSSMultipartUploadDemo;
- (void)runOSSMD5UploadDemo;


// download
- (void) runOSSSimpleDownloadDemo;
- (void) runOSSScopeDownloadDemo;
- (void) runOSSSHeaderDownloadDemo;
- (void) runOSSDownloadWithBlockDemo;

@end

#endif /* AliyunOSSDemoTest_h */
