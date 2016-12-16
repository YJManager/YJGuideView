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
    UILabel *labelInit = [[UILabel alloc] initWithFrame:[view _ovalFrameScale:frame ratio:0.5]];
    labelInit.font = [UIFont systemFontOfSize:15];
    labelInit.textAlignment = NSTextAlignmentLeft;
    labelInit.backgroundColor = [UIColor redColor];
    [self.view addSubview:labelInit];
    
    
}


@end
