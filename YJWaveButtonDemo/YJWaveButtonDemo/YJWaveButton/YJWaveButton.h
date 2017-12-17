//
//  YJWaveButton.h
//  YiJianDoctor
//
//  Created by YJHou on 15/12/2.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CompletionBlock)(BOOL success);


@interface YJWaveButton : UIView{
@private
    UIImageView *imageView;
    UILabel *title;
    UITapGestureRecognizer *gesture;
    SEL methodName;
    id superSender;
    UIColor *rippleColor;
    NSArray *rippleColors;
    BOOL isRippleOn;
}

@property (nonatomic, weak) NSTimer * Ntimer;

@property (nonatomic, copy) CompletionBlock block;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image target:(SEL)target sender:(id)sender;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image completion:(CompletionBlock)completionBlock;

-(void)setRippleEffectWithColor:(UIColor *)color;
-(void)setRippeEffectEnabled:(BOOL)setRippeEffectEnabled;

- (void)btnWaveActive;
- (void)setFirstWaveBtn;
- (void)setDownWaveBtn;

@end
