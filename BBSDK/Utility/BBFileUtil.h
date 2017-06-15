//
//  BBFileUtil.h
//  bbframework
//
//  Created by book on 16/11/2.
//
//

#import <Foundation/Foundation.h>

#import "BBMacros.h"

@interface BBFileUtil : NSObject

SingletonH;

/**
 *文件是否存在
 *filePath 绝对路径
 */
- (BOOL)fileExits:(NSString *)filePath;

/**
 *删除文件
 *filePath 绝对路径
 */
- (BOOL)removeFile:(NSString *)filePath;

/**
 *获取home文件路径
 */
- (NSString *)getHomePath;

/**
 *获取Documents文件路径
 */
- (NSString *)getDocumentsPath;

/**
 *获取Caches文件路径
 */
- (NSString *)getCachesPath;

/**
 *获取tmp文件路径
 */
- (NSString *)getTmpPath;

/**
 *创建文件夹
 */
- (BOOL)createFile:(NSString *)path;

/**
 *  获取指定目录的路径
 *
 *  @param directory 目录枚举
 *
 *  @return 目录路径
 */
- (NSString *)getDirectoryPath:(NSSearchPathDirectory)directory;

/**
 *  指定目录下创建文件夹
 *
 *  @param directory  目录
 *  @param folderName 文件夹名称
 *
 *  @return 创建结果
 */
- (NSString *)createFolderInDirectory:(NSSearchPathDirectory)directory folder:(NSString *)folderName;

/**
 获取指定文件路径
 
 @param directory 主
 @param folderName 目录
 @param file 文件名
 @return 全路径
 */
- (NSString *)getFilePathInDirectory:(NSSearchPathDirectory)directory folder:(NSString *)folderName fileName:(NSString *)file;

/*
 *文件重命名
 */
- (BOOL)renameFile:(NSString *)filePath moveFile:(NSString *)targetPath targetName:(NSString *)targetName;

/**
 创建文件
 @param directorys 文件路径
 @return 返回文件url
 */
- (NSURL *)createDirectory:(NSArray *)directorys;

-(NSURL *)createDirectoryWithFileName:(NSString *)filePath;

- (NSArray *)getAllFileNamesWithPath:(NSString *)path;

/**
 删除文件下超出的子文件
 @param path 路径
 @param num 超出的数量
 */
- (void)removeBeyondItems:(NSString *)path beyondNum:(int)num;

@end
