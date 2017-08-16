//
//  DEWCountdown.h
//  Countdown
//
//  Created by Shaw on 2017/8/11.
//  Copyright © 2017年 Dawa Co., Ltd. All rights reserved.
//

//  @Abstract 暂时只支持一个页面一个倒计时

#import <Foundation/Foundation.h>

@protocol DEWCountdownDelegate <NSObject>

@optional

- (void)countdownWillStart;
- (void)countdownDidStarted;

//剩余多少秒给出的是精确时间，会带很多小数点，用的时候可以用 (int)round(seconds) 来进行四舍五入
- (void)countdowningWithSeconds:(NSTimeInterval)seconds;
- (void)countdownDidFinished;

@end


@interface DEWCountdown : NSObject

@property (nonatomic, weak) id<DEWCountdownDelegate> delegate;

//倒计时间隔，需要赋值，默认为30
@property (nonatomic, assign) NSTimeInterval maxInterval;

//当前时间间隔
@property (nonatomic, assign, readonly) NSTimeInterval currentInterval;

- (void)start;

//一般情况下，不需要手动调这个方法，不建议使用
- (void)stop;


@end
