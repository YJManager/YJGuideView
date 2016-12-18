//
//  YJGuideViewController.h
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YJGuideViewAnchorType) {
    YJGuideViewAnchorRect,        //矩形
    YJGuideViewAnchorRoundRect,  // 圆角矩形
    YJGuideViewAnchorOval        //椭圆
};

@interface YJGuideViewController : UIViewController

@property (nonatomic, strong) UIImage            *  screenshotImage;  /**< 上一页截屏生成图片 */
@property (nonatomic, strong) NSArray <NSValue *>*  showRects;        /**< 显示的焦点Frame */
@property (nonatomic, strong) NSArray <NSNumber *>* showTypes;        /**< 显示类型 */
@property (nonatomic, strong) NSArray <NSNumber *>* endoOutCuts;      /**< 内切和外切 */


@end
