//
//  ViewController.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ViewController.h"
#import "YJGuideViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [imageView setImage:[UIImage imageNamed:@"IMG_4829.PNG"]];
    [self.view addSubview:imageView];
    
    
    UILabel *labelInit = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 30, 60)];
    labelInit.font = [UIFont systemFontOfSize:15];
    labelInit.textAlignment = NSTextAlignmentLeft;
    labelInit.backgroundColor = [UIColor redColor];
    [self.view addSubview:labelInit];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGRect frame1 = CGRectMake(270, 240, 58, 58);
    CGRect frame2 = CGRectMake(50, 260, 58, 58);
    CGRect frame3 = CGRectMake(200, 64, 158, 58);

    YJGuideViewController *guidevc = [[YJGuideViewController alloc] init];
    guidevc.showRects = @[[NSValue valueWithCGRect:frame1], [NSValue valueWithCGRect:frame2], [NSValue valueWithCGRect:frame3]];
    guidevc.showTypes = @[@0, @1, @2];
    guidevc.endoOutCuts = @[@0, @1, @0];
    [self presentViewController:guidevc animated:NO completion:^{
        NSLog(@"已经弹出了guide --- 出现");
    }];
}




@end
