//
//  YJGuideView.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJGuideView.h"
#import <CoreText/CoreText.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_CONRNERRADIUS (5.0f)

@interface YJGuideView ()

@property (nonatomic, assign) BOOL isClean; /**< 是否清除 */

@end

@implementation YJGuideView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        self.showRect = self.bounds;
        self.fullShow = YES;
        self.guideBgColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.68];
        self.isClean = NO;
        self.showType = YJGuideViewAnchorRect;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.isClean){
        CGContextClearRect(context, self.bounds);
        CGContextStrokeRect(context, self.bounds);
        self.layer.contents = nil;
        self.isClean = NO;
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.12f];
    }else{
        // 1. 获取
        CGRect frame = [self convertRect:self.bounds toView: self.superview];
        UIImage *fullImage = [self _getImageFromView:self.superview];
        CGFloat scale = UIScreen.mainScreen.scale;
        UIImage *image = [self _getImageFromImage:fullImage rect:CGRectMake(frame.origin.x*scale, frame.origin.y*scale, frame.size.width*scale, frame.size.height*scale)];
//        [image drawInRect:self.bounds];
        
        CGContextSetFillColorWithColor(context, self.guideBgColor.CGColor);
        UIBezierPath *fullPath  = [UIBezierPath bezierPathWithRect:self.bounds];
        switch (self.showType){
            case YJGuideViewAnchorOval:{ // 椭圆
                UIBezierPath *showPath = [UIBezierPath bezierPathWithOvalInRect:self.fullShow?([self _scaleFrame:self.showRect ratio:[self ovalDrawScale]]):self.showRect];
                [fullPath appendPath:[showPath bezierPathByReversingPath]];
            }
                break;
            case YJGuideViewAnchorRoundRect:{ // 圆角矩形
                UIBezierPath *showPath = [UIBezierPath bezierPathWithRoundedRect:self.fullShow?([self scaleFrame:self.showRect addBorderWidth:DEFAULT_CONRNERRADIUS]):self.showRect cornerRadius:DEFAULT_CONRNERRADIUS];
                [fullPath appendPath:[showPath bezierPathByReversingPath]];
            }
                break;
            default:{ // 矩形
                UIBezierPath *showPath = [UIBezierPath bezierPathWithRect:self.fullShow?([self scaleFrame:self.showRect addBorderWidth:2]):self.showRect];
                [fullPath appendPath:[showPath bezierPathByReversingPath]];
            }
                break;
        }
        CGContextAddPath(context, fullPath.CGPath);
        CGContextFillPath(context);
//        CGContextStrokePath(context);
        self.isClean = YES;
    }
}
-(void)drawMark{
    CGRect showLocationRect = self.showRect;
    if (self.fullShow){
        switch (self.showType){
            case YJGuideViewAnchorOval:{
                showLocationRect = [self _scaleFrame:self.showRect ratio:[self ovalDrawScale]];
            }
                break;
            case YJGuideViewAnchorRoundRect:{
                showLocationRect = [self scaleFrame:self.showRect addBorderWidth:DEFAULT_CONRNERRADIUS];
            }
                break;
            default:{
                showLocationRect = [self scaleFrame:self.showRect addBorderWidth:2];
            }
                break;
        }
    }
    CGPoint showCenter = CGPointMake(CGRectGetMinX(showLocationRect), CGRectGetMinY(showLocationRect));
    NSLog(@"-%@", NSStringFromCGPoint(showCenter));
    
}

#pragma mark - Lazy
-(void)setShowRect:(CGRect)showRect{
    _showRect = showRect;
    [self setNeedsDisplay];
}

-(void)setFullShow:(BOOL)fullShow{
    _fullShow = fullShow;
    [self setNeedsDisplay];
}

- (void)setGuideBgColor:(UIColor *)guideBgColor{
    _guideBgColor = guideBgColor;
    [self setNeedsDisplay];
}


- (void)setShowType:(YJGuideViewAnchorType)showType{
    _showType = showType;
    [self setNeedsDisplay];
}

#pragma mark - Setting_Support
/** 从view截取生成Image */
- (UIImage *)_getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 生成新尺寸的image */
- (UIImage *)_getImageFromImage:(UIImage *)image rect:(CGRect)rect{
    CGImageRef sourceImageRef = image.CGImage;
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage* newImage = [UIImage imageWithCGImage:newImageRef];
    CFRelease(newImageRef);
    return newImage;
}

/** 根据 比例缩放 调整Frame */
-(CGRect)_scaleFrame:(CGRect)rect ratio:(CGFloat)ratio{
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGRect newRect = CGRectMake(center.x - width * ratio * 0.5, center.y - height * ratio * 0.5, width * ratio, height * ratio);
    return newRect;
}

/** 根据 边缘宽度 调整Frame */
- (CGRect)scaleFrame:(CGRect)rect addBorderWidth:(CGFloat)borderWidth{
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGRect newRect = CGRectMake(center.x - width * 0.5 - borderWidth, center.y - height * 0.5 - borderWidth, width + borderWidth * 2.0, height + borderWidth * 2.0);
    
    return newRect;
}

/** 椭圆的外切矩形是内切矩形的多少倍 */
-(CGFloat)ovalDrawScale{
    return sqrt(2); //scale;
}





@end
