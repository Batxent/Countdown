//
//  DEWCountdown.m
//  Countdown
//
//  Created by Shaw on 2017/8/11.
//  Copyright © 2017年 Dawa Co., Ltd. All rights reserved.
//

#import "DEWCountdown.h"
#import <UIKit/UIKit.h>//https://gitlab.com/fier/Countdown

@interface DEWCountdown ()

@property (nonatomic, assign, readwrite) NSTimeInterval currentInterval;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSString *dateKey;
@property (nonatomic, assign) BOOL onFire;

@end


@implementation DEWCountdown

- (void)start
{
    
    if (!self.onFire) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(countdownWillStart)]) {
            [self.delegate countdownWillStart];
        }
        
        if (self.currentInterval == 0) {
            [[NSUserDefaults standardUserDefaults]setDouble:[NSDate date].timeIntervalSince1970 forKey:self.dateKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [self.timer fire];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(countdownDidStarted)]) {
            [self.delegate countdownDidStarted];
        }
    }
    
}

- (void)stop
{

    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    
    self.timer = nil;
    
}

#pragma mark - Privite

- (void)timerRun:(NSTimer *)sender
{
    self.onFire = YES;
    self.currentInterval --;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(countdowningWithSeconds:)]) {
        [self.delegate countdowningWithSeconds:self.currentInterval];
    }
    
    if (self.currentInterval == 0) {
        [self stop];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(countdownDidFinished)]) {
            [self.delegate countdownDidFinished];
        }
        
        self.onFire = NO;
    }
}

#pragma mark - Setters and getters

-  (NSTimeInterval)currentInterval
{
    double date = [[NSUserDefaults standardUserDefaults]doubleForKey:self.dateKey];
    
    NSTimeInterval timeInterval = 0;
    if (date) {
        NSDate* lastSMSCodeDate = [NSDate dateWithTimeIntervalSince1970:date];
        NSDate *currentDate = [NSDate date];
        timeInterval = [currentDate timeIntervalSinceDate:lastSMSCodeDate];
        NSTimeInterval a = self.maxInterval - timeInterval;
        if (a < 0) {
            a = 0;
        }
        return a;
    }else {
        return 0;
    }
}

- (NSTimeInterval)maxInterval
{
    if (_maxInterval == 0) return 30;

    return _maxInterval;
}

#ifdef __IPHONE_10_0

- (NSTimer *)timer
{
    
    if (_timer) return _timer;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             repeats:YES
                                               block:^(NSTimer * _Nonnull timer) {
                                                   [self timerRun:timer];
                                               }];
    return _timer;
}

#else

- (NSTimer *)timer
{
    
    if (_timer) return _timer;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(timerRun:)
                                            userInfo:nil
                                             repeats:YES];
    return _timer;
}

#endif

- (NSString *)dateKey
{
    
    if (_dateKey) return _dateKey;
    
    //需要支持一个页面共存多个倒计时，只需要修改这里_dataKey的生成即可
    
    NSString *selfClassName = NSStringFromClass([self class]);
    _dateKey = [NSString stringWithFormat:@"%@_dateKey",selfClassName];
    
    return _dateKey;
}

- (void)dealloc
{
    
    [self.timer invalidate];
    self.timer = nil;
}



@end
