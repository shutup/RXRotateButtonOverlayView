//
//  RotateBtnView.h
//  jspatch
//
//  Created by tom on 16/4/5.
//  Copyright © 2016年 donler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RXRotateButtonOverlayViewDelegate <NSObject>
- (void)didSelected:(NSUInteger)index;
@end

@interface RXRotateButtonOverlayView : UIView

@property (nonatomic, weak) id<RXRotateButtonOverlayViewDelegate> delegate;
//初始化使用的菜单名称
@property (nonatomic, strong) NSArray* titles;
//初始化使用的菜单图片
@property (nonatomic, strong) NSArray* titleImages;
//展示
- (void)show;
//消失
- (void)dismiss;
@end
