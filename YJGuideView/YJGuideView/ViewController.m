//
//  ViewController.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ViewController.h"
#import "YJGuideView.h"
#import <CoreText/CoreText.h>
#import <CoreImage/CoreImage.h>
#import "YJGuideViewController.h"


@interface ViewController () {
    YJGuideView *markView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    
//    YJGuideView *view = [[YJGuideView alloc] init];
//    CGRect frame = CGRectMake(100, 100, 100, 100);
//    view.showRect = frame;
//    
//    UILabel *firstLabel = [[UILabel alloc] initWithFrame:frame];
//    firstLabel.font = [UIFont systemFontOfSize:15];
//    firstLabel.textAlignment = NSTextAlignmentLeft;
//    firstLabel.backgroundColor = [UIColor redColor];
////    [self.view addSubview:firstLabel];
//    
//    
//    CGRect secFrame = [view _scaleFrame:frame ratio:[view ovalDrawScale]];
//    UILabel *secLabel = [[UILabel alloc] initWithFrame:secFrame];
//    secLabel.font = [UIFont systemFontOfSize:15];
//    secLabel.textAlignment = NSTextAlignmentLeft;
//    secLabel.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
////    [self.view addSubview:secLabel];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIBezierPath *fullPath  = [UIBezierPath bezierPathWithRect:frame];
//    UIBezierPath *showPath = [UIBezierPath bezierPathWithOvalInRect:[view _scaleFrame:view.showRect ratio:[view ovalDrawScale]]];
//    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
//    [fullPath appendPath:[showPath bezierPathByReversingPath]];
//    CGContextAddPath(context, fullPath.CGPath);
//    CGContextFillPath(context);


    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [imageView setImage:[UIImage imageNamed:@"IMG_4829.PNG"]];
    [self.view addSubview:imageView];
    
    
    UILabel *labelInit = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 30, 60)];
    labelInit.font = [UIFont systemFontOfSize:15];
    labelInit.textAlignment = NSTextAlignmentLeft;
    labelInit.backgroundColor = [UIColor redColor];
    [self.view addSubview:labelInit];

    
    CGRect frame = CGRectMake(270, 240, 58, 58);
    
    markView = [[YJGuideView alloc]initWithFrame:imageView.bounds];
    markView.fullShow = YES;
    markView.showType = YJGuideViewAnchorOval;
    markView.showRect = frame;
    [imageView addSubview:markView];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    CGPoint point = [[touches anyObject] locationInView:markView.superview];
//    markView.showRect = CGRectMake(point.x-markView.showRect.size.width/2.0f, point.y-markView.showRect.size.height/2.0f, markView.showRect.size.width, markView.showRect.size.height);
    [markView removeFromSuperview];
    
    CGRect frame1 = CGRectMake(270, 240, 58, 58);
    CGRect frame2 = CGRectMake(50, 260, 58, 58);
    CGRect frame3 = CGRectMake(200, 64, 58, 58);

    YJGuideViewController *guidevc = [[YJGuideViewController alloc] init];
    guidevc.screenshotImage = [self _getImageFromView:[UIApplication sharedApplication].keyWindow];
    guidevc.showRects = @[[NSValue valueWithCGRect:frame1], [NSValue valueWithCGRect:frame2], [NSValue valueWithCGRect:frame3]];
    guidevc.showTypes = @[@0, @1, @2];
    [self presentViewController:guidevc animated:NO completion:^{
        NSLog(@"已经弹出了guide --- 出现");
    }];
}

/** 从view截取生成Image */
- (UIImage *)_getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



@end
