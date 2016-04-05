//
//  RotateBtnView.m
//  jspatch
//
//  Created by tom on 16/4/5.
//  Copyright © 2016年 donler. All rights reserved.
//

#import "RXRotateButtonOverlayView.h"

static CGFloat labelWidth = 60.0f;
static CGFloat labelOffsetY = 80.0;

@interface RXRotateButtonOverlayView ()
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UIButton* mainBtn;
@property (nonatomic, strong) NSMutableArray* labels;
@end

@implementation RXRotateButtonOverlayView

- (instancetype)init
{
    if (self=[super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self builtInterface];
    }
    return self;
}

- (void)builtInterface
{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedSelf:)]];
    
    if (self.titles.count > 0) {
        for (NSString* title in self.titles) {
            UIView* v = [self addLabelWithName:title];
            [self.labels addObject:v];
        }
        [self addSubview:self.mainBtn];
    }
}

- (UIView*)addLabelWithName:(NSString*)title
{
    UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - labelWidth / 2.0, [UIScreen mainScreen].bounds.size.height - labelOffsetY, labelWidth, labelWidth)];
    view.textColor = [UIColor whiteColor];
    view.backgroundColor = [UIColor yellowColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 30;
    view.text = title;
    view.textAlignment = NSTextAlignmentCenter;
    view.font = [UIFont systemFontOfSize:17];
    [self addSubview:view];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLabelAction:)]];
    return view;
}
- (UIDynamicAnimator *)animator
{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return _animator;
}
- (UIButton *)mainBtn
{
    if (_mainBtn == nil) {
        _mainBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - labelWidth / 2.0, [UIScreen mainScreen].bounds.size.height - labelOffsetY, labelWidth, labelWidth)];
        [_mainBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_mainBtn setBackgroundColor:[UIColor blueColor]];
    }
    return _mainBtn;
}

- (NSMutableArray *)labels
{
    if (_labels == nil) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}
- (void)selectLabelAction:(UITapGestureRecognizer*)gesture
{
    UILabel* l = (UILabel*)gesture.view;
    NSLog(@"%@",l.text);
    if ([self.delegate respondsToSelector:@selector(didSelected:)]) {
        [self.delegate didSelected:[self.titles indexOfObject:l.text]];
    }
}

- (void)setTitles:(NSArray *)titles
{
    self.labels = [NSMutableArray array];
    _titles = [NSArray arrayWithArray:titles];
    [self builtInterface];
}

- (void)clickedSelf:(id)sender
{
    [self dismiss];
}
- (void)btnClicked:(id)sender
{
    
}

- (void)show
{
    self.mainBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
    NSInteger count = self.labels.count;
    CGFloat space = 0;
    space = ([UIScreen mainScreen].bounds.size.width - count * labelWidth ) / (count + 1 );
    [self.animator removeAllBehaviors];
    for (int i = 0; i< count; i++) {
        CGPoint buttonPoint=  CGPointMake((i + 1)* (space ) + (i+0.5) * labelWidth, [UIScreen mainScreen].bounds.size.height - labelOffsetY*2);
        UISnapBehavior *sna = [[UISnapBehavior alloc]initWithItem:[self.labels objectAtIndex:i] snapToPoint:buttonPoint];
        sna.damping = .5;
        [self.animator addBehavior:sna];
    }
}

- (void)dismiss
{
    self.mainBtn.transform = CGAffineTransformMakeRotation(M_PI / 180.0);
    NSInteger count = self.labels.count;
    CGPoint point = self.mainBtn.center;
    [self.animator removeAllBehaviors];
    for (int i = 0; i< count; i++) {
        UISnapBehavior *sna = [[UISnapBehavior alloc]initWithItem:[self.labels objectAtIndex:i] snapToPoint:point];
        sna.damping = .9;
        [self.animator addBehavior:sna];
    }
//    [UIView animateWithDuration:.5 animations:^{
//        [self removeFromSuperview];
//
//    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

@end
