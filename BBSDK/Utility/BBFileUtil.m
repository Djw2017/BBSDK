//
//  BBFileUtil.m
//  bbframework
//
//  Created by book on 16/11/2.
//
//

#import "BBFileUtil.h"
#import "BBSystemUtil.h"

@implementation BBFileUtil

/**
 *文件是否存在
 *filePath 绝对路径
 */
+ (BOOL)fileExits:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

/**
 *删除文件
 *filePath 绝对路径
 */
+ (BOOL)removeFile:(NSString *)filePath {
    NSError *error;
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
}




#pragma mark - 获取
/**
 *获取home文件路径
 */
+ (NSString *)getHomePath {
    return NSHomeDirectory();
}

/**
 *获取Documents文件路径
 */
+ (NSString *)getDocumentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   return [paths objectAtIndex:0];
}

/**
 *获取Caches文件路径
 */
+ (NSString *)getCachesPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

/**
 *获取tmp文件路径
 */
+ (NSString *)getTmpPath {
    return NSTemporaryDirectory();
}

/**
 *  获取指定目录的路径
 *
 *  @param directory 目录枚举
 *
 *  @return 目录路径
 */
+ (NSString *)getDirectoryPath:(NSSearchPathDirectory)directory {
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
 获取指定文件路径
 
 @param directory 主
 @param folderName 目录
 @param file 文件名
 @return 全路径
 */
+ (NSString *)getFilePathInDirectory:(NSSearchPathDirectory)directory folder:(NSString *)folderName fileName:(NSString *)file{
    NSString *directoryPath = [self getDirectoryPath:directory];
    directoryPath = [directoryPath stringByAppendingString:[NSString stringWithFormat:@"%@%@",folderName,file]];
    return directoryPath;
}

/**
 根据文件名与系统目录获取绝对路径
 
 @param directory 开始目录
 @param name 文件名
 @param extension 文件后缀
 @return 文件绝对路径
 */
+ (NSString *)getFilePathInDirectory:(NSSearchPathDirectory)directory fileName:(NSString *)name fileExtension:(NSString *)extension {
    NSString *document = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES).lastObject;
    NSString *path =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,extension]];
    return path;
}

/**
 获取文件大小
 
 @param path 文件绝对路径
 @return 文件大小
 */
+ (long )getFileSizeForPath:(NSString *)path {
    NSDictionary* dictFile = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    long nFileSize = (long)[dictFile fileSize];
    return nFileSize;
}




#pragma mark - 创建
/**
 *创建文件夹
 */
+ (BOOL)createFile:(NSString *)path {
    NSError *error;
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
}

/**
 *  指定目录下创建文件夹
 *
 *  @param directory  目录
 *  @param folderName 文件夹名称
 *
 *  @return 创建结果
 */
+ (NSString *)createFolderInDirectory:(NSSearchPathDirectory)directory folder:(NSString *)folderName {
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

/*
 *文件重命名
 */
+ (BOOL)renameFile:(NSString *)filePath moveFile:(NSString *)targetPath targetName:(NSString *)targetName {
    NSError *error;
    NSString *target = [targetPath stringByAppendingPathComponent:targetName];
    return [[NSFileManager defaultManager] moveItemAtPath:filePath toPath:target error:&error];
}

+ (NSURL *)createDirectory:(NSArray *)directorys {
    
    __block NSURL *documentURL = nil;
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    documentURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];
    //拼接文件夹路径
    for (NSString *dir in directorys) {
        documentURL = [documentURL URLByAppendingPathComponent:dir];
    }
    //获取文件夹属性
    NSDictionary *properties = [documentURL resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsDirectoryKey] error:&error];
    if (properties == nil)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //创建文件夹， withIntermediateDirectories = YES (创建额外需要的文件夹，创建父目录不存在的子目录，自动将父目录创建)
            if (![fileManager createDirectoryAtPath:[documentURL path] withIntermediateDirectories:YES attributes:nil error:nil])
            {
                NSLog(@"不能创建目录 %@\n%@",[documentURL path], [error localizedDescription]);
                documentURL = nil;
            }
        });
    }
    NSLog(@"创建路径成功%@", [documentURL absoluteString]);
    
    return documentURL;
}

+ (NSURL *)createDirectoryWithFileName:(NSString *)filePath {
    
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

/**
 获取文件夹下所有文件的名称
 @param path 路径
 @return 包含文件夹名称的数组
 */
+ (NSArray *)getAllFileNamesWithPath:(NSString *)path{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
}

+ (NSDictionary *)getFileInfo:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager fileAttributesAtPath:filePath traverseLink:YES];
    return fileAttributes;
}

#pragma mark - 移除
/**
 根据创建时间升序，删除文件下超出传入个数的子文件
 @param path 路径
 @param num 超出的数量
 */
+ (void)removeBeyondItems:(NSString *)path beyondNum:(int)num {
    
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
