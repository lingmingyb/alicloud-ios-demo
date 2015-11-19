//
//  AliyunOSSCommonSupport.h
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/18.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#ifndef AliyunOSSCommonSupport_h
#define AliyunOSSCommonSupport_h

@interface AliyunOSSCommonSupport : NSObject

+ (NSString *)getDocumentDirectory;

+ (void) initLocalFile;

// create a file with size of fileSize in the fixed path, and return the file path.
+ (NSString *)createTempFile : (NSString * ) fileName fileSize : (int) size;

// clear all the temp files.
+ (void)clearAllTempFile;

@end

#endif /* AliyunOSSCommonSupport_h */
