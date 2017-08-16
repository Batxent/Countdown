//
//  ViewController.m
//  Countdown
//
//  Created by Shaw on 2017/8/11.
//  Copyright © 2017年 Dawa Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "DEWCountdown.h"


@interface ViewController ()<DEWCountdownDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) DEWCountdown *countdown;

@end


@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.countdown.currentInterval) {
        [self.countdown start];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.button];
    
    [self _layoutPageSubviews];
}

#pragma mark - Privite

- (void)_layoutPageSubviews
{

    self.label.frame = CGRectMake(0, 100, self.view.bounds.size.width, 60);
    self.button.frame = CGRectMake((self.view.bounds.size.width - 100) / 2.0, 200, 100, 60);
}


#pragma mark - DEWCountdownDelegate

//不需要设置按钮的userinterfaceEnable，但是如果按钮黑了之后显示上依然有被点击的效果，那也可以设置一下

- (void)countdownWillStart
{
    //发请求什么的

}

- (void)countdownDidStarted
{
    //更改按钮样式
    
}

//倒计时中
- (void)countdowningWithSeconds:(NSTimeInterval)seconds
{
    
    self.label.text = [NSString stringWithFormat:@"%d",(int)round(seconds)];
    
}

- (void)countdownDidFinished
{
    //更改按钮样式
    
}

#pragma mark - Event response

- (void)buttonClicked:(UIButton *)sender
{
    [self.countdown start];
    
}

#pragma mark - Setters and getters

- (UIButton *)button
{
    if (_button) return _button;
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"开始倒计时" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _button;
}

- (UILabel *)label
{
    if (_label) return _label;
    _label = [[UILabel alloc]init];
    _label.textAlignment = NSTextAlignmentCenter;
    
    return _label;

}

- (DEWCountdown *)countdown
{
    if (_countdown) return _countdown;
    _countdown = [[DEWCountdown alloc]init];
    _countdown.delegate = self;

    return _countdown;
}

@end


