//
//  YJGuideViewController.h
//  YJGuideView
//
//  Created by YJHou on 2016/12/16.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJGuideViewController : UIViewController

// 相关参数设置
@property (nonatomic, strong) NSArray <NSValue *> * showRects;        /**< 显示的焦点Frame */
@property (nonatomic, strong) NSArray <NSNumber *>* showTypes;        /**< 显示类型 */
@property (nonatomic, strong) NSArray <NSNumber *>* endoOutCuts;      /**< 内切和外切 */
@property (nonatomic, strong) NSArray <NSNumber *>* roundRectConrnerradius;      /**< 圆角矩形的值 */
@property (nonatomic, strong) NSArray <NSValue *>* markShowRects;      /**< 提示的Rect */
@property (nonatomic, strong) NSArray <UIImage *>* markShowImages;      /**< 提示的Images */


@end
