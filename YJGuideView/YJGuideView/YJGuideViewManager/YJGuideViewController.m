//
//  YJGuideViewController.m
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJGuideViewController.h"
#import "YJGuideViewManager.h"

@interface YJGuideViewController () <XSpotDelegate>

@property (nonatomic, assign) NSInteger currentIndex; /**< 当前显示位置 */
@property (nonatomic, strong) YJGuideViewManager *guideManager;
@property (nonatomic, strong) UIView *showView; /**< 显示样式 */

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
    
}

#pragma mark - Lazy
- (YJGuideViewManager *)guideManager{
    if (_guideManager == nil) {
        _guideManager = [[YJGuideViewManager alloc] init];
        _guideManager.hintDelegate = self;
    }
    return _guideManager;
}

- (void)viewTapActionClick:(UITapGestureRecognizer *)tapGest{
    self.currentIndex++;
    if (self.currentIndex >= self.showRects.count) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }else{
        if (self.showView.superview) {
            [self.showView removeFromSuperview];
            [self show];
        }
    }
}

- (void)show{
    self.showView = [self.guideManager presentModalMessage:@"你猜猜" where:self.view];
    [self.view addSubview:self.showView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapActionClick:)];
    [self.showView addGestureRecognizer:tapGest];
}

#pragma mark - Delegate
-(NSArray*)hintStateRectsToHint:(id)hintState{
    NSArray* rectArray = nil;
    NSValue *value = [self.showRects objectAtIndex:self.currentIndex];
    CGRect rect = value.CGRectValue;
    rectArray = [[NSArray alloc] initWithObjects:[NSValue valueWithCGRect:rect], nil];
    return rectArray;
}
-(void)hintStateWillClose:(id)hintState{
    NSLog(@" hintStateWillClose : %@",hintState);
}
-(void)hintStateDidClose:(id)hintState{
    NSLog(@" hintStateDidClose : %@",hintState);
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
