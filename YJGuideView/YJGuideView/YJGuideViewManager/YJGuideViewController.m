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
@property (nonatomic, strong) UIImageView *markImageView; /**< 提示视图 */

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
    CGFloat roundRectConrnerradius = [self.roundRectConrnerradius objectAtIndex:self.currentIndex].doubleValue;
    self.showView = [self _showViewWithShowRect:showFrame showType:showType fullShow:fullShow roundRectConrnerradius:roundRectConrnerradius];
    [self.view addSubview:self.showView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapActionClick:)];
    [self.showView addGestureRecognizer:tapGest];
}

- (void)viewTapActionClick:(UITapGestureRecognizer *)tapGest{
    self.currentIndex++;
    if (self.currentIndex >= self.showRects.count) {
        [self dismissViewControllerAnimated:NO completion:^{

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
- (UIView *)_showViewWithShowRect:(CGRect)frame showType:(NSNumber *)showType fullShow:(NSNumber *)fullShow roundRectConrnerradius:(CGFloat)roundRectConrnerradius{
    
    YJGuideView *guideView = [[YJGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    guideView.delegate = self;
    guideView.fullShow = fullShow.boolValue;
    if (showType.integerValue == YJGuideViewAnchorRect) {
        guideView.showType = YJGuideViewAnchorRect;
    }else if (showType.integerValue == YJGuideViewAnchorRoundRect){
        guideView.showType = YJGuideViewAnchorRoundRect;
        guideView.roundRectConrnerradius = roundRectConrnerradius;
    }else if (showType.integerValue == YJGuideViewAnchorOval){
        guideView.showType = YJGuideViewAnchorOval;
    }
    guideView.showRect = frame;
    
    return guideView;
}

#pragma mark - YJGuideViewDelegate
- (void)yjGuideView:(YJGuideView *)guideView currentShowRect:(CGRect)showRect{
    CGRect markRect = [self.markShowRects objectAtIndex:self.currentIndex].CGRectValue;
    UIImage *markImage = [self.markShowImages objectAtIndex:self.currentIndex];
    self.markImageView.frame = markRect;
    self.markImageView.image = markImage;
    [self.view bringSubviewToFront:self.markImageView];
    
}

#pragma mark - Lazy
- (UIImageView *)markImageView{
    if (_markImageView == nil) {
        _markImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _markImageView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:_markImageView];
    }
    return _markImageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"YJGuideViewController is dealloc");
#endif
}
@end
