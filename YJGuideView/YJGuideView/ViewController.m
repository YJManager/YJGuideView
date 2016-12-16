//
//  ViewController.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ViewController.h"
#import "YJGuideView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJGuideView *view = [[YJGuideView alloc] init];
    
    CGRect frame = CGRectMake(100, 100, 100, 100);
    
    UILabel *bgLabel = [[UILabel alloc] initWithFrame:frame];
    bgLabel.font = [UIFont systemFontOfSize:13];
    bgLabel.textAlignment = NSTextAlignmentLeft;
    bgLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bgLabel];

    UILabel *labelInit = [[UILabel alloc] initWithFrame:[view scaleFrame:frame addBorderWidth:-5]];
    labelInit.font = [UIFont systemFontOfSize:15];
    labelInit.textAlignment = NSTextAlignmentLeft;
    labelInit.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:labelInit];
    
    
}


@end
