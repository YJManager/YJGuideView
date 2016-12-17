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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YJGuideView *view = [[YJGuideView alloc] init];
    CGRect frame = CGRectMake(100, 100, 100, 100);
    view.showRect = frame;
    
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:frame];
    firstLabel.font = [UIFont systemFontOfSize:15];
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.backgroundColor = [UIColor redColor];
//    [self.view addSubview:firstLabel];
    
    
    CGRect secFrame = [view _scaleFrame:frame ratio:[view ovalDrawScale]];
    UILabel *secLabel = [[UILabel alloc] initWithFrame:secFrame];
    secLabel.font = [UIFont systemFontOfSize:15];
    secLabel.textAlignment = NSTextAlignmentLeft;
    secLabel.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
//    [self.view addSubview:secLabel];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *fullPath  = [UIBezierPath bezierPathWithRect:frame];
    UIBezierPath *showPath = [UIBezierPath bezierPathWithOvalInRect:[view _scaleFrame:view.showRect ratio:[view ovalDrawScale]]];
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    [fullPath appendPath:[showPath bezierPathByReversingPath]];
    CGContextAddPath(context, fullPath.CGPath);
    CGContextFillPath(context);


    
    
    
    NSLog(@"++++ %f", [view ovalDrawScale]);
}


@end
