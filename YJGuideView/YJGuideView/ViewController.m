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


@interface ViewController (){
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
    [imageView setImage:[UIImage imageNamed:@"meizi.jpg"]];
    [self.view addSubview:imageView];
    
    CGRect frame = CGRectMake(210, 380, 120, 50);
    
    markView = [[YJGuideView alloc]initWithFrame:imageView.bounds];
    markView.fullShow = YES;
    markView.showType = YJGuideViewAnchorOval;
    markView.showRect = frame;
    [imageView addSubview:markView];
    
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:frame];
    firstLabel.font = [UIFont systemFontOfSize:15];
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.backgroundColor = [UIColor redColor];
//    [imageView addSubview:firstLabel];
    
    CGRect secFrame = [markView _scaleFrame:frame ratio:[markView ovalDrawScale]];
    UILabel *secLabel = [[UILabel alloc] initWithFrame:secFrame];
    secLabel.font = [UIFont systemFontOfSize:15];
    secLabel.textAlignment = NSTextAlignmentLeft;
    secLabel.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
//    [imageView addSubview:secLabel];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:markView.superview];
    markView.showRect = CGRectMake(point.x-markView.showRect.size.width/2.0f, point.y-markView.showRect.size.height/2.0f, markView.showRect.size.width, markView.showRect.size.height);
    markView.markString = NSStringFromCGPoint(point);
}


@end
