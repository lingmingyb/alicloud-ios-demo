//
//  AliyunOSSCommonSupport.m
//  oss_ios_demo
//
//  Created by 凌琨 on 15/11/18.
//  Copyright © 2015年 zhouzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AliyunOSSCommonSupport.h"

// constant value
NSString * const AccessKey = @"<enter your access key>";
NSString * const SecretKey = @"<enter your secret key>";
NSString * const endPoint = @"<enter your endpoint>";


@implementation AliyunOSSCommonSupport

// get local file dir which is readwrite able
+ (NSString *)getDocumentDirectory {
    NSString * path = NSHomeDirectory();
    NSLog(@"NSHomeDirectory:%@",path);
    NSString * userName = NSUserName();
    NSString * rootPath = NSHomeDirectoryForUser(userName);
    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

// create some random file for demo cases
+ (void)initLocalFile {
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString * mainDir = [self getDocumentDirectory];
    
    NSArray * fileNameArray = @[@"file1k", @"file10k", @"file100k", @"file1m", @"file10m", @"fileDirA/", @"fileDirB/"];
    NSArray * fileSizeArray = @[@1024, @10240, @102400, @1024000, @10240000, @1024, @1024];
    
    NSMutableData * basePart = [NSMutableData dataWithCapacity:1024];
    for (int i = 0; i < 1024/4; i++) {
        u_int32_t randomBit = arc4random();
        [basePart appendBytes:(void*)&randomBit length:4];
    }
    
    for (int i = 0; i < [fileNameArray count]; i++) {
        NSString * name = [fileNameArray objectAtIndex:i];
        long size = [[fileSizeArray objectAtIndex:i] longValue];
        NSString * newFilePath = [mainDir stringByAppendingPathComponent:name];
        if ([fm fileExistsAtPath:newFilePath]) {
            [fm removeItemAtPath:newFilePath error:nil];
        }
        [fm createFileAtPath:newFilePath contents:nil attributes:nil];
        NSFileHandle * f = [NSFileHandle fileHandleForWritingAtPath:newFilePath];
        for (int k = 0; k < size/1024; k++) {
            [f writeData:basePart];
        }
        [f closeFile];
    }
    NSLog(@"main bundle: %@", mainDir);
}

// create a file with size of fileSize in the fixed path, and return the file path.
+ (NSString *)createTempFile : (NSString * ) fileName fileSize : (int) size {
    NSString * tempFileDirectory;
    NSString * path = NSHomeDirectory();
    tempFileDirectory = [NSString stringWithFormat:@"%@/%@/%@", path, @"tmp", fileName];
    //NSLog(@"%@", tempFileDirectory);
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:tempFileDirectory]){
        [fm removeItemAtPath:tempFileDirectory error:nil];
    }
    
    [fm createFileAtPath:tempFileDirectory contents:nil attributes:nil];
    NSFileHandle * fh = [NSFileHandle fileHandleForWritingAtPath:tempFileDirectory];
    NSMutableData * basePart = [NSMutableData dataWithCapacity:size];
    for (int i = 0; i < size/4; i++) {
        u_int32_t randomBit = arc4random();
        [basePart appendBytes:(void*)&randomBit length:4];
    }
    [fh writeData:basePart];
    [fh closeFile];
    return tempFileDirectory;
}


// delelte all temp files
+ (void)clearAllTempFile {
    NSString * tempFileDirectory;
    tempFileDirectory = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), @"tmp"];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator * direnum = [fm enumeratorAtPath:tempFileDirectory];
    NSString * fileName;
    NSString * filePath;
    while (fileName = [direnum nextObject]) {
        filePath = [NSString stringWithFormat:@"%@/%@", tempFileDirectory, fileName];
        if ([fm fileExistsAtPath:filePath]) {
            [fm removeItemAtPath:filePath error:nil];
        }
    }
    
}


@end
