//
//  YJGuideView.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJGuideView.h"

#define UP_ARROW_IMAGE ([UIImage imageNamed:@"fx_my_attention_guide_arrow"])
#define DOWN_ARROW_IMAGE ([UIImage imageNamed:@"fx_guide_arrow_down"])
#define DEFAULT_CONRNERRADIUS (5.0f)

@interface YJGuideView ()

@property (nonatomic, strong) UITextView *markTextView; /**< 提示文本 */
@property (nonatomic, strong) UIImageView *markImageView; /**< 提示图片 */
@property (nonatomic, assign) BOOL isClean; /**< 是否清除 */

@end

@implementation YJGuideView

-(void)setShowRect:(CGRect)showRect
{
    _showRect = showRect;
    [self setNeedsDisplay];
}

- (void)setMarkShow:(BOOL)markShow{
    _markShow = markShow;
    [self setNeedsDisplay];
}

-(void)setFullShow:(BOOL)fullShow
{
    _fullShow = fullShow;
    [self setNeedsDisplay];
}

- (void)setGuideBgColor:(UIColor *)guideBgColor{
    _guideBgColor = guideBgColor;
    [self setNeedsDisplay];
}

- (void)setMarkString:(NSString *)markString{
    _markString = [markString copy];
    self.markTextView.text = _markString;
    [self setNeedsDisplay];
}

- (void)setShowType:(YJGuideViewAnchorType)showType{
    _showType = showType;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.isClean){
        CGContextClearRect(context, self.bounds);
        CGContextStrokeRect(context, self.bounds);
        self.layer.contents = nil;
        [self.markTextView removeFromSuperview];
        [self.markImageView removeFromSuperview];
        self.isClean = NO;
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.12f];
    }else{
        CGRect frame = [self convertRect:self.bounds toView: self.superview];
        UIImage *fullImage = [self imageFromView:self.superview];
        CGFloat scale = UIScreen.mainScreen.scale;
        UIImage *image = [self imageFromImage:fullImage rect:CGRectMake(frame.origin.x*scale, frame.origin.y*scale, frame.size.width*scale, frame.size.height*scale)];
        [image drawInRect:self.bounds];
        CGContextSetFillColorWithColor(context, self.guideBgColor.CGColor);
        UIBezierPath *fullPath  = [UIBezierPath bezierPathWithRect:self.bounds];
        switch (self.showType)
        {
            case YJGuideViewAnchorOval:
            {
                UIBezierPath *showPath = [UIBezierPath bezierPathWithOvalInRect:self.fullShow?([self ovalFrameScale:self.showRect s:[self ovalDrawScale]]):self.showRect];
                [fullPath appendPath:[showPath bezierPathByReversingPath]];
            }
                break;
            case YJGuideViewAnchorRoundRect:
            {
                UIBezierPath *showPath = [UIBezierPath bezierPathWithRoundedRect:self.fullShow?([self roundRectScale:self.showRect]):self.showRect cornerRadius:DEFAULT_CONRNERRADIUS];
                [fullPath appendPath:[showPath bezierPathByReversingPath]];
            }
                break;
            default:
            {
                UIBezierPath *showPath = [UIBezierPath bezierPathWithRect:self.fullShow?([self rectScale:self.showRect]):self.showRect];
                [fullPath appendPath:[showPath bezierPathByReversingPath]];
            }
                break;
        }
        CGContextAddPath(context, fullPath.CGPath);
        CGContextFillPath(context);
        if (self.markShow) {
            [self drawMark];
        }
        else
        {
            [self.markTextView removeFromSuperview];
            [self.markImageView removeFromSuperview];
        }
        self.isClean = YES;
    }
}
-(void)drawMark
{
    CGRect showLocationRect = self.showRect;
    if (self.fullShow)
    {
        switch (self.showType)
        {
            case YJGuideViewAnchorOval:
            {
                showLocationRect = [self ovalFrameScale:self.showRect s:[self ovalDrawScale]];
            }
                break;
            case YJGuideViewAnchorRoundRect:
            {
                showLocationRect = [self roundRectScale:self.showRect];
            }
                break;
            default:
            {
                showLocationRect = [self rectScale:self.showRect];
            }
                break;
        }
    }
    CGPoint markCenter = CGPointMake(CGRectGetMinX(showLocationRect), CGRectGetMinY(showLocationRect));
    CGFloat centerX = self.bounds.size.width/2.0f;
    CGFloat centerY = self.bounds.size.height/2.0f;
    if (markCenter.x<=centerX&&markCenter.y<=centerY)//左上
    {
        CGFloat right = (self.bounds.size.width-showLocationRect.origin.x-showLocationRect.size.width)*(self.bounds.size.height-showLocationRect.origin.y);
        CGFloat bottom = (self.bounds.size.width-showLocationRect.origin.x)*(self.bounds.size.height-showLocationRect.origin.y-showLocationRect.size.height);
        if (right>=bottom)//右侧
        {
            [self.markImageView setFrame:CGRectMake(showLocationRect.origin.x+showLocationRect.size.width, showLocationRect.origin.y, self.markImageView.frame.size.width, self.markImageView.frame.size.height)];
            [self.markImageView setImage:UP_ARROW_IMAGE];
            [self.markImageView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4)];
            [self addSubview:self.markImageView];
            
            CGFloat width = self.bounds.size.width-showLocationRect.origin.x-showLocationRect.size.width-self.markImageView.frame.size.width;
            CGFloat height = self.bounds.size.height-showLocationRect.origin.y-self.markImageView.frame.size.height;
            CGSize size = [self.markTextView sizeThatFits:CGSizeMake(width, height)];
            [self.markTextView setFrame:CGRectMake(self.markImageView.frame.origin.x+self.markImageView.frame.size.width-self.markTextView.font.pointSize, self.markImageView.frame.origin.y+self.markImageView.frame.size.height, size.width, size.height)];
            [self addSubview:self.markTextView];
        }
        else//下面
        {
            [self.markImageView setFrame:CGRectMake(showLocationRect.origin.x, showLocationRect.origin.y+showLocationRect.size.height, self.markImageView.frame.size.width, self.markImageView.frame.size.height)];
            [self.markImageView setImage:DOWN_ARROW_IMAGE];
            [self.markImageView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, M_PI)];
            [self addSubview:self.markImageView];
            CGFloat width = self.bounds.size.width-showLocationRect.origin.x-self.markImageView.frame.size.width;
            CGFloat height = self.bounds.size.height-showLocationRect.origin.y-showLocationRect.size.height-self.markImageView.frame.size.height;
            CGSize size = [self.markTextView sizeThatFits:CGSizeMake(width, height)];
            [self.markTextView setFrame:CGRectMake(self.markImageView.frame.origin.x+self.markImageView.frame.size.width, self.markImageView.frame.origin.y+self.markImageView.frame.size.height-self.markTextView.font.pointSize, size.width, size.height)];
            [self addSubview:self.markTextView];
        }
    }
    else if (markCenter.x>=centerX&&markCenter.y<=centerY)//右上
    {
        CGFloat left = (showLocationRect.origin.x)*(self.bounds.size.height-showLocationRect.origin.y);
        CGFloat bottom = (showLocationRect.origin.x+showLocationRect.size.width)*(self.bounds.size.height-showLocationRect.origin.y-showLocationRect.size.height);
        if (left>=bottom)//左侧
        {
            [self.markImageView setFrame:CGRectMake(showLocationRect.origin.x-self.markImageView.frame.size.width, showLocationRect.origin.y, self.markImageView.frame.size.width, self.markImageView.frame.size.height)];
            [self.markImageView setImage:DOWN_ARROW_IMAGE];
            [self.markImageView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4)];
            [self addSubview:self.markImageView];
            CGFloat width = showLocationRect.origin.x-self.markImageView.frame.size.width;
            CGFloat height = self.bounds.size.height-showLocationRect.origin.y-self.markImageView.frame.size.height;
            CGSize size = [self.markTextView sizeThatFits:CGSizeMake(width, height)];
            [self.markTextView setFrame:CGRectMake(self.markImageView.frame.origin.x-size.width+self.markTextView.font.pointSize, self.markImageView.frame.origin.y+self.markImageView.frame.size.height, size.width, size.height)];
            [self addSubview:self.markTextView];
        }
        else//下面
        {
            [markImageView setFrame:CGRectMake(showLocationRect.origin.x+showLocationRect.size.width-markImageView.frame.size.width, showLocationRect.origin.y+showLocationRect.size.height, markImageView.frame.size.width, markImageView.frame.size.height)];
            [markImageView setImage:UPIMAGE];
            [markImageView setTransform:CGAffineTransformIdentity];
            [self addSubview:markImageView];
            CGFloat width = showLocationRect.origin.x+showLocationRect.size.width-markImageView.frame.size.width;
            CGFloat height = self.bounds.size.height-showLocationRect.origin.y-showLocationRect.size.height-markImageView.frame.size.height;
            CGSize size = [markTextView sizeThatFits:CGSizeMake(width, height)];
            [markTextView setFrame:CGRectMake(markImageView.frame.origin.x-size.width, markImageView.frame.origin.y+markImageView.frame.size.height-markTextView.font.pointSize, size.width, size.height)];
            [self addSubview:markTextView];
        }
    }
    else if (markCenter.x<=centerX&&markCenter.y>=centerY)//左下
    {
        CGFloat right = (self.bounds.size.width-showLocationRect.origin.x-showLocationRect.size.width)*(showLocationRect.origin.y+showLocationRect.size.height);
        CGFloat up = (self.bounds.size.width-showLocationRect.origin.x)*(showLocationRect.origin.y);
        if (right>=up)//右侧
        {
            [markImageView setFrame:CGRectMake(showLocationRect.origin.x+showLocationRect.size.width, showLocationRect.origin.y+showLocationRect.size.height-markImageView.frame.size.height, markImageView.frame.size.width, markImageView.frame.size.height)];
            [markImageView setImage:DOWNIMAGE];
            [markImageView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4)];
            [self addSubview:markImageView];
            CGFloat width = self.bounds.size.width-showLocationRect.origin.x-showLocationRect.size.width-markImageView.frame.size.width;
            CGFloat height = showLocationRect.origin.y+showLocationRect.size.height-markImageView.frame.size.height;
            CGSize size = [markTextView sizeThatFits:CGSizeMake(width, height)];
            [markTextView setFrame:CGRectMake(markImageView.frame.origin.x+markImageView.frame.size.width-markTextView.font.pointSize, markImageView.frame.origin.y-size.height, size.width, size.height)];
            [self addSubview:markTextView];
        }
        else//上面
        {
            [markImageView setFrame:CGRectMake(showLocationRect.origin.x, showLocationRect.origin.y-markImageView.frame.size.height, markImageView.frame.size.width, markImageView.frame.size.height)];
            [markImageView setImage:UPIMAGE];
            [markImageView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, M_PI)];
            [self addSubview:markImageView];
            CGFloat width = self.bounds.size.width-showLocationRect.origin.x-markImageView.frame.size.width;
            CGFloat height = showLocationRect.origin.y-markImageView.frame.size.height;
            CGSize size = [markTextView sizeThatFits:CGSizeMake(width, height)];
            [markTextView setFrame:CGRectMake(markImageView.frame.origin.x+markImageView.frame.size.width, markImageView.frame.origin.y-size.height+markTextView.font.pointSize, size.width, size.height)];
            [self addSubview:markTextView];
        }
    }
    else if (markCenter.x>=centerX&&markCenter.y>=centerY)//右下
    {
        CGFloat left = (showLocationRect.origin.x)*(showLocationRect.origin.y+showLocationRect.size.height);
        CGFloat up = (showLocationRect.origin.x+showLocationRect.size.width)*(showLocationRect.origin.y);
        if (left>=up)//左侧
        {
            [markImageView setFrame:CGRectMake(showLocationRect.origin.x-markImageView.frame.size.width, showLocationRect.origin.y+showLocationRect.size.height-markImageView.frame.size.height, markImageView.frame.size.width, markImageView.frame.size.height)];
            [markImageView setImage:UPIMAGE];
            [markImageView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4)];
            [self addSubview:markImageView];
            CGFloat width = showLocationRect.origin.x-markImageView.frame.size.width;
            CGFloat height = showLocationRect.origin.y+showLocationRect.size.height-markImageView.frame.size.height;
            CGSize size = [markTextView sizeThatFits:CGSizeMake(width, height)];
            [markTextView setFrame:CGRectMake(markImageView.frame.origin.x-size.width+markTextView.font.pointSize, markImageView.frame.origin.y-size.height, size.width, size.height)];
            [self addSubview:markTextView];
        }
        else//上面
        {
            [markImageView setFrame:CGRectMake(showLocationRect.origin.x+showLocationRect.size.width-markImageView.frame.size.width, showLocationRect.origin.y-markImageView.frame.size.height, markImageView.frame.size.width, markImageView.frame.size.height)];
            [markImageView setImage:DOWNIMAGE];
            [markImageView setTransform:CGAffineTransformIdentity];
            [self addSubview:markImageView];
            CGFloat width = showLocationRect.origin.x+showLocationRect.size.width-markImageView.frame.size.width;
            CGFloat height = showLocationRect.origin.y-markImageView.frame.size.height;
            CGSize size = [markTextView sizeThatFits:CGSizeMake(width, height)];
            [markTextView setFrame:CGRectMake(markImageView.frame.origin.x-size.width, markImageView.frame.origin.y-size.height+markTextView.font.pointSize, size.width, size.height)];
            [self addSubview:markTextView];
        }
    }
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showRect = self.bounds;
        self.fullShow = YES;
        self.guideColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.68];
        isClean = NO;
        self.showMark = YES;
        self.markText = @"说明性文字";
        self.model = GuideViewCleanModeOval;
        markImageView = [[UIImageView alloc]initWithImage:UPIMAGE];
        [markImageView setFrame:CGRectMake(0, 0, 70, 70)];
        [markImageView setContentMode:UIViewContentModeScaleAspectFit];
        markTextView = [[UITextView alloc]initWithFrame:CGRectZero];
        [markTextView setEditable:NO];
        [markTextView setTextColor:[UIColor whiteColor]];
        [markTextView setFont:[UIFont systemFontOfSize:16.0f]];
        [markTextView setScrollEnabled:NO];
        [markTextView setText:self.markText];
        [markTextView setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
-(CGRect)roundRectScale:(CGRect)rect
{
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGRect newRect = CGRectMake(center.x - width * 0.5 - DEFAULTCORNERRADIUS, center.y - height * 0.5 - DEFAULTCORNERRADIUS, width + DEFAULTCORNERRADIUS * 2.0, height + DEFAULTCORNERRADIUS * 2.0);
    
    return newRect;
}
-(CGRect)rectScale:(CGRect)rect
{
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGRect newRect = CGRectMake(center.x - width * 0.5 - 2.0, center.y - height * 0.5 - 2.0, width + 4.0, height + 4.0);
    
    return newRect;
}
-(CGFloat)ovalDrawScale
{
    CGFloat a = MAX(self.showRect.size.width, self.showRect.size.height);
    CGFloat b = MIN(self.showRect.size.width, self.showRect.size.height);
    CGFloat bigger = (b + sqrt(4.0 * a * a + b * b) - 2 * a)/2.0;
    CGFloat scale = 1.0 + bigger / a;
    return scale;
}

#pragma mark - Lazy

#pragma mark - Setting_Support
/** 从View截取生成Image */
-(UIImage*)imageFromView:(UIView*)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(CGRect)ovalFrameScale:(CGRect)rect s:(CGFloat)s
{
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGRect newRect = CGRectMake(center.x - width * s * 0.5, center.y - height * s * 0.5, width * s, height * s);
    
    return newRect;
    
    
    
}

-(UIImage*)imageFromImage:(UIImage*)image rect:(CGRect)rect
{
    CGImageRef sourceImageRef = image.CGImage;
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage* newImage = [UIImage imageWithCGImage:newImageRef];
    CFRelease(newImageRef);
    return newImage;
}

@end
