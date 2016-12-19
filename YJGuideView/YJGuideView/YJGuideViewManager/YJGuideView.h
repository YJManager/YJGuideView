//
//  YJGuideView.h
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

@interface YJGuideView : UIView

@property (nonatomic, assign) CGRect                  showRect;      /**< 锚点frame */
@property (nonatomic, assign) YJGuideViewAnchorType   showType;      /**< 锚点显示类型 */
@property (nonatomic, assign, getter=isFullShow) BOOL fullShow;      /**< 是否外切 */
@property (nonatomic, strong) UIColor *               guideBgColor;  /**< 覆盖的颜色 */
@property (nonatomic, assign) CGFloat roundRectConrnerradius;        /**< 圆角矩形的圆角值 */


@end
