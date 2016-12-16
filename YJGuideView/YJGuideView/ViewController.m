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
    view.showRect = frame;
    
    NSLog(@"++++ %f", [view ovalDrawScale]);
}


@end
