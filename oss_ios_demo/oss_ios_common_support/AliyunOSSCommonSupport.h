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


+ (NSString *)createTempFile : (NSString * ) fileName fileSize : (int) size;
+ (void)clearAllTempFile;

@end

#endif /* AliyunOSSCommonSupport_h */
