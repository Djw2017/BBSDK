//
//  BBUIUtil.m
//  BBSDK
//
//  Created by Dongjw on 17/5/12.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#import "BBUIUtil.h"

@implementation BBUIUtil

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        
        for (UIView *view in [rootViewController.view subviews])
        {
            id subViewController = [view nextResponder];    // Key property which most of us are unaware of / rarely use.
            if ( subViewController && [subViewController isKindOfClass:[UIViewController class]])
            {
                return [self topViewControllerWithRootViewController:subViewController];
            }
        }
        return rootViewController;
    }
}

+ (UIViewController*)topViewController {
    
    //TODO 暂时没有考虑 UIPopoverController
    return [BBUIUtil topViewControllerWithRootViewController:[BBUIUtil getCurrentVC]];
}

+ (UINavigationController *)topNavigationController {
    
    if ([[self topViewController] isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)[self topViewController];
    }
    
    return [self topViewController].navigationController;
}

+ (UIWindow *)window {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        for(window in [UIApplication sharedApplication].windows) {
            if (window.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    return window;
}

+ (UIView *)topView {
    
    return [BBUIUtil topViewController].view;
}

+ (UIView *)currentView {
    
    return [BBUIUtil getCurrentVC].view;
}

+ (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    
    if (result == nil) {
        UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *topVC = appRootVC;
        if (topVC.presentedViewController) {
            result = topVC.presentedViewController;
        }
    }
    
    if (result) {
        return result;
    }

    UIViewController *rootViewCtr = nil;
    
    UIWindow *window = [BBUIUtil window];
    
    if (nil == window.rootViewController) {
        ///fix bug
        if ([[window subviews] count] < 1) {
            return nil;
        }
        UIView *rootView = [[window subviews] objectAtIndex:0];
        id nextResponder = [rootView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            rootViewCtr = nextResponder;
        }
    }else {
        rootViewCtr = window.rootViewController;
    }
    
    return rootViewCtr;
}

#pragma mark - Orientation

+ (NSString *)stringWithOrientation:(UIInterfaceOrientation)orientation {
    
    if (orientation == UIInterfaceOrientationPortrait) {
        return @"UIInterfaceOrientationPortrait";
    }else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return @"UIInterfaceOrientationPortraitUpsideDown";
    }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return @"UIInterfaceOrientationLandscapeLeft";
    }else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return @"UIInterfaceOrientationLandscapeRight";
        
    }
    return @"UIInterfaceOrientationUnKnow";
}

+ (NSArray *)supportOrientations {
    
    static dispatch_once_t once;
    static NSArray *__supportedOrientations = nil;
    
    dispatch_once( &once, ^{
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            __supportedOrientations = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UISupportedInterfaceOrientations"];
        }else {
            __supportedOrientations = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UISupportedInterfaceOrientations"];
        }
    });
    return __supportedOrientations;
}

+ (BOOL)isSupportOrientation:(UIInterfaceOrientation)orientation {
    
    BOOL isSupport = NO;
    
    for (NSString *sup in [BBUIUtil supportOrientations]) {
        if ([sup isEqualToString:[BBUIUtil stringWithOrientation:orientation]]) {
            isSupport = YES;
        }
    }
    
    return isSupport;
}

+ (BOOL)isSupportPortraitOrientation {
    
    return [BBUIUtil isSupportOrientation:UIInterfaceOrientationPortrait] || [BBUIUtil isSupportOrientation:UIInterfaceOrientationPortraitUpsideDown];
}
+ (BOOL)isSupportLandscapeOrientation {
    
    return [BBUIUtil isSupportOrientation:UIInterfaceOrientationLandscapeLeft] || [BBUIUtil isSupportOrientation:UIInterfaceOrientationLandscapeRight];
}




//*****************************************  颜色 *************************************************//
#pragma mark - 颜色
/**
 *  根据颜色返回图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
//根据颜色返回图片
+(UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  根据颜色返回图片
 *
 *  @param color 十六进制颜色
 *
 *  @return 图片
 */
+ (UIView *)getCellBottomLineViewWithColor:(NSString *)color
{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [self colorWithHexString:color];
    return lineView;
}

/**
 字符串16进制颜色转化真正颜色
 
 @param hexString 888888
 @return 对应UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [self colorWithHexString:hexString withAlpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString withAlpha:(float)alpha  {
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

//*****************************************  图片 *************************************************//
#pragma mark - 图片
//图片自定义长宽
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

+ (UIImage *)imageiPhoneOriPadWithName:(NSString *)name {
    UIImage *image;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        image=[UIImage imageNamed:[NSString stringWithFormat:@"%@_pad",name]];
    }
    else{
        image=[UIImage imageNamed:name];
    }
    return image;
}

/**
 图片等比例缩小

 @param image <#image description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+ (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

/**
 保持原来的长宽比，生成一个缩略图

 @param image <#image description#>
 @param asize <#asize description#>
 @return <#return value description#>
 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize {
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.x = 0;
            //rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[self colorWithHexString:@"ececec"] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background 透明填充多出来的区域
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}




//*****************************************  图片 *************************************************//
/**
 16：9的比例

 @return 比例
 */
+ (float)getScreenFactor {
    CGRect rect = [[UIScreen mainScreen] bounds];
    if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
        if (rect.size.width < rect.size.height) {
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
        }
        float scaleX = rect.size.width / 960;
        float scaleY = rect.size.height / 540;
        if (scaleX > scaleY ) {
            return scaleY;
        }else{
            return scaleX;
        }
    }else{
        if (rect.size.width > rect.size.height) {
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
        }
        float scaleX = rect.size.width / 540;
        float scaleY = rect.size.height / 960;
        if (scaleX > scaleY ) {
            return scaleY;
        }else{
            return scaleX;
        }
    }
}

/**
 获取屏幕高度比例
 @return 屏幕高度比例
 */
+ (float)getHieghtFactor {
    CGRect rect = [[UIScreen mainScreen] bounds];
    if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
        if (rect.size.width < rect.size.height) {
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
        }
        
        float width = rect.size.width;
        float height = rect.size.height;
        
        return height / (width / 960) / 540;
    }else{
        if (rect.size.width > rect.size.height) {
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
        }
        
        float width = rect.size.width;
        float height = rect.size.height;
        
        return width / (height / 960) / 540;
    }
}

/// 像素转换为字体大小
+ (float)qsh_systemFontOfSize:(CGFloat)pxSize {
    float pt = (pxSize/96)*72;
    return pt;
}

@end
