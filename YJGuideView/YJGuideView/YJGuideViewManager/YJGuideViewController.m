//
//  YJGuideViewController.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJGuideViewController.h"
#import "YJGuideView.h"

@interface YJGuideViewController ()

@property (nonatomic, assign) NSInteger currentIndex; /**< 当前显示位置 */
@property (nonatomic, strong) UIView *showView; /**< 显示样式 */
@property (nonatomic, strong) UIColor *guideBgColor; /**< 覆盖的颜色 */

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
    [self _drawScreenshotImageInSelfView];
    self.guideBgColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.68];
    [self show];
}

#pragma mark - Lazy
- (void)viewTapActionClick:(UITapGestureRecognizer *)tapGest{
    self.currentIndex++;
    if (self.currentIndex >= self.showRects.count) {
        [self dismissViewControllerAnimated:NO completion:^{
            NSLog(@"已经消失了guide --- 消失");
        }];
    }else{
        
        if (self.showView.superview) {
            [self.showView removeFromSuperview];
            self.showView = nil;
            [self show];
        }
    }
}

- (void)show{
    CGRect showFrame = [self.showRects objectAtIndex:self.currentIndex].CGRectValue;
    NSNumber *showType = [self.showTypes objectAtIndex:self.currentIndex];
    self.showView = [self _showViewWithShowRect:showFrame showType:showType];
    [self.view addSubview:self.showView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapActionClick:)];
    [self.showView addGestureRecognizer:tapGest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)_drawScreenshotImageInSelfView{
    CGFloat scale = UIScreen.mainScreen.scale;
    UIImage *image = [self _getImageFromImage:self.screenshotImage rect:CGRectMake(0, 0, self.view.bounds.size.width * scale, self.view.bounds.size.height * scale)];
    [image drawInRect:self.view.bounds];
}

#pragma mark - SettingSupport
/** 生成新尺寸的image */
- (UIImage *)_getImageFromImage:(UIImage *)image rect:(CGRect)rect{
    CGImageRef sourceImageRef = image.CGImage;
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage* newImage = [UIImage imageWithCGImage:newImageRef];
    CFRelease(newImageRef);
    return newImage;
}

- (UIView *)_showViewWithShowRect:(CGRect)frame showType:(NSNumber *)showType{
    
    YJGuideView *guideView = [[YJGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    guideView.fullShow = YES;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
