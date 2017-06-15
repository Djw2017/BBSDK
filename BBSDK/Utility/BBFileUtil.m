//
//  BBFileUtil.m
//  bbframework
//
//  Created by book on 16/11/2.
//
//

#import "BBFileUtil.h"



@implementation BBFileUtil

SingletonM;

/**
 *文件是否存在
 *filePath 绝对路径
 */
- (BOOL)fileExits:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

/**
 *删除文件
 *filePath 绝对路径
 */
- (BOOL)removeFile:(NSString *)filePath
{
    NSError *error;
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
}

/**
 *获取home文件路径
 */
- (NSString *)getHomePath
{
    return NSHomeDirectory();
}

/**
 *获取Documents文件路径
 */
- (NSString *)getDocumentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   return [paths objectAtIndex:0];
}

/**
 *获取Caches文件路径
 */
- (NSString *)getCachesPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

/**
 *获取tmp文件路径
 */
- (NSString *)getTmpPath
{
    return NSTemporaryDirectory();
}

/**
 *创建文件夹
 */
- (BOOL)createFile:(NSString *)path
{
    NSError *error;
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
}

/**
 *  获取指定目录的路径
 *
 *  @param directory 目录枚举
 *
 *  @return 目录路径
 */
- (NSString *)getDirectoryPath:(NSSearchPathDirectory)directory
{
    NSArray *paths = nil;
    switch (directory) {
        case NSDocumentDirectory:
            paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            break;
        case NSCachesDirectory:
            paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            break;
        case NSLibraryDirectory:
            paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            break;
        default:
            break;
    }
    NSString *path = [paths objectAtIndex:0];
    return path;
}

/**
 *  指定目录下创建文件夹
 *
 *  @param directory  目录
 *  @param folderName 文件夹名称
 *
 *  @return 创建结果
 */
- (NSString *)createFolderInDirectory:(NSSearchPathDirectory)directory folder:(NSString *)folderName
{
    NSString *directoryPath;
    BOOL isDir              = YES;
    directoryPath = [self getDirectoryPath:directory];
    directoryPath = [directoryPath stringByAppendingString:folderName];
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir];
    NSError *error;
    if (!isExists) {
        BOOL isSucceed = [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!isSucceed) {
            directoryPath = nil;
        }
    }
    return directoryPath;
}

/**
 获取指定文件路径

 @param directory 主
 @param folderName 目录
 @param file 文件名
 @return 全路径
 */
- (NSString *)getFilePathInDirectory:(NSSearchPathDirectory)directory folder:(NSString *)folderName fileName:(NSString *)file{
    NSString *directoryPath;
    directoryPath = [self getDirectoryPath:directory];
    directoryPath = [directoryPath stringByAppendingString:[NSString stringWithFormat:@"%@%@",folderName,file]];
    return directoryPath;
}

/*
 *文件重命名
 */
- (BOOL)renameFile:(NSString *)filePath moveFile:(NSString *)targetPath targetName:(NSString *)targetName
{
    NSError *error;
    NSString *target = [targetPath stringByAppendingPathComponent:targetName];
    return [[NSFileManager defaultManager] moveItemAtPath:filePath toPath:target error:&error];
}

-(NSURL *)createDirectory:(NSArray *)directorys
{
    NSURL *documentURL = nil;
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    documentURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];
    //拼接文件夹路径
    for (NSString *dir in directorys) {
        documentURL = [documentURL   URLByAppendingPathComponent:dir];
    }
    //获取文件夹属性
    NSDictionary *properties = [documentURL resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsDirectoryKey] error:&error];
    if (properties == nil)
    {
        //创建文件夹， withIntermediateDirectories = YES (创建额外需要的文件夹，创建父目录不存在的子目录，自动将父目录创建)
        if (![fileManager createDirectoryAtPath:[documentURL path] withIntermediateDirectories:YES attributes:nil error:&error])
        {
            NSLog(@"不能创建目录 %@\n%@",[documentURL path], [error localizedDescription]);
            documentURL = nil;
        }
    }
    NSLog(@"创建路径成功%@", [documentURL absoluteString]);
    
    return documentURL;
}

-(NSURL *)createDirectoryWithFileName:(NSString *)filePath
{
    NSArray *directorys = [filePath componentsSeparatedByString:@"/"];
    NSURL *documentURL = nil;
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    documentURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];
    //拼接文件夹路径
    for (NSString *dir in directorys) {
        documentURL = [documentURL   URLByAppendingPathComponent:dir];
    }
    //获取文件夹属性
    NSDictionary *properties = [documentURL resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsDirectoryKey] error:&error];
    if (properties == nil)
    {
        //创建文件夹， withIntermediateDirectories = YES (创建额外需要的文件夹，创建父目录不存在的子目录，自动将父目录创建)
        if (![fileManager createDirectoryAtPath:[documentURL path] withIntermediateDirectories:YES attributes:nil error:&error])
        {
            NSLog(@"不能创建目录 %@\n%@",[documentURL path], [error localizedDescription]);
            documentURL = nil;
        }
    }
    NSLog(@"创建路径成功%@", [documentURL absoluteString]);
    
    return documentURL;
}

- (NSArray *)getAllFileNamesWithPath:(NSString *)path
{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
}

- (void)removeBeyondItems:(NSString *)path beyondNum:(int)num
{
    NSArray *arrays = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    if ([arrays count] > num) {
        NSArray *sortedPaths = [arrays sortedArrayUsingComparator:^(NSString * firstPath, NSString* secondPath) {//
            NSString *firstUrl = [path stringByAppendingPathComponent:firstPath];//获取前一个文件完整路径
            NSString *secondUrl = [path stringByAppendingPathComponent:secondPath];//获取后一个文件完整路径
            NSDictionary *firstFileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:firstUrl error:nil];//获取前一个文件信息
            NSDictionary *secondFileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:secondUrl error:nil];//获取后一个文件信息
            id firstData = [firstFileInfo objectForKey:NSFileCreationDate];//获取前一个文件修改时间
            id secondData = [secondFileInfo objectForKey:NSFileCreationDate];//获取后一个文件修改时间
            return [firstData compare:secondData];//升序
            //         return [secondData compare:firstData];//降序
        }];
        
        for (int i = num; i < [sortedPaths count]; i++) {
            NSString *path_ = [NSString stringWithFormat:@"%@/%@", path, sortedPaths[i]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path_]) {
                [[NSFileManager defaultManager] removeItemAtPath:path_ error:nil];
            }
        }
    }
}

@end
