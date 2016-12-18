//
//  YJGuideView.h
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJGuideViewController.h"

@interface YJGuideView : UIView

@property (nonatomic, assign) CGRect showRect; /**< 锚点frame */
@property (nonatomic, assign) YJGuideViewAnchorType showType; /**< 锚点显示类型 */
@property (nonatomic, assign, getter=isFullShow) BOOL fullShow; /**< 锚点全部显示 */
@property (nonatomic, strong) UIColor *guideBgColor; /**< 覆盖的颜色 */

/////////////////////////////
@property (nonatomic, strong) NSArray *showRects; /**< 显示的Position */
@property (nonatomic, strong) NSArray *showRadius; /**< 显示的圆角 */

- (id)initWithFrame:(CGRect)frame forViews:(NSArray*)viewArray;
- (id)initWithFrame:(CGRect)frame withRects:(NSArray*)rectArray;

@end
