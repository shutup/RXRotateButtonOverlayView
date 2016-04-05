//
//  ViewController.m
//  RXRotateButtonOverlayViewDemo
//
//  Created by shutup on 16/4/5.
//  Copyright © 2016年 shutup. All rights reserved.
//

#import "ViewController.h"
#import "RXRotateButtonOverlayView.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController () <RXRotateButtonOverlayViewDelegate>

@property (nonatomic, strong) RXRotateButtonOverlayView* overlayView;
@property (nonatomic, strong) UIButton* btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - action
- (void)btnClicked:(UIButton*)btn
{
    [self.view addSubview:self.overlayView];
    [self.overlayView show];
}

#pragma mark - RXRotateButtonOverlayViewDelegate
- (void)didSelected:(NSUInteger)index
{
    NSLog(@"clicked %zd btn",index);
}

#pragma mark - getter
- (UIButton *)btn
{
    if (_btn == nil) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2.0,SCREEN_HEIGHT - 300, 100, 44)];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setBackgroundColor:[UIColor greenColor]];
    }
    return _btn;
}
- (RXRotateButtonOverlayView *)overlayView
{
    if (_overlayView == nil) {
        _overlayView = [[RXRotateButtonOverlayView alloc] init];
        [_overlayView setTitles:@[@"test1",@"test2",@"test3"]];
        [_overlayView setDelegate:self];
    }
    return _overlayView;
}
@end
