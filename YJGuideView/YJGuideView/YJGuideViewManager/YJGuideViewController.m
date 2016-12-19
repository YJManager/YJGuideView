//
//  YJGuideViewController.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJGuideViewController.h"
#import "YJGuideView.h"

@interface YJGuideViewController () <YJGuideViewDelegate>

@property (nonatomic, assign) NSInteger currentIndex; /**< 当前显示位置 */
@property (nonatomic, strong) UIView *showView; /**< 显示样式View */

@end

@implementation YJGuideViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.currentIndex = 0;
    [self show];
}

- (void)show{
    CGRect showFrame = [self.showRects objectAtIndex:self.currentIndex].CGRectValue;
    NSNumber *showType = [self.showTypes objectAtIndex:self.currentIndex];
    NSNumber *fullShow = [self.endoOutCuts objectAtIndex:self.currentIndex];
    self.showView = [self _showViewWithShowRect:showFrame showType:showType fullShow:fullShow];
    [self.view addSubview:self.showView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapActionClick:)];
    [self.showView addGestureRecognizer:tapGest];
}

- (void)viewTapActionClick:(UITapGestureRecognizer *)tapGest{
    self.currentIndex++;
    if (self.currentIndex >= self.showRects.count) {
        [self dismissViewControllerAnimated:NO completion:^{
#ifdef DEBUG
            NSLog(@"YJGuideViewController -- Already disappeared");
#endif
        }];
    }else{
        
        if (self.showView.superview) {
            [self.showView removeFromSuperview];
            self.showView = nil;
            [self show];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}


#pragma mark - SettingSupport
- (UIView *)_showViewWithShowRect:(CGRect)frame showType:(NSNumber *)showType fullShow:(NSNumber *)fullShow{
    
    YJGuideView *guideView = [[YJGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    guideView.delegate = self;
    guideView.fullShow = fullShow.boolValue;
    if (showType.integerValue == YJGuideViewAnchorRect) {
        guideView.showType = YJGuideViewAnchorRect;
    }else if (showType.integerValue == YJGuideViewAnchorRoundRect){
        guideView.showType = YJGuideViewAnchorRoundRect;
    }else if (showType.integerValue == YJGuideViewAnchorOval){
        guideView.showType = YJGuideViewAnchorOval;
    }
    guideView.showRect = frame;
    
    return guideView;
}

#pragma mark - YJGuideViewDelegate
- (void)yjGuideView:(YJGuideView *)guideView currentShowRect:(CGRect)showRect{
    NSLog(@"-%@", NSStringFromCGRect(showRect));
}

#pragma mark - Lazy


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"YJGuideViewController is dealloc");
#endif
}
@end
