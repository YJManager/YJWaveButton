//
//  YJWaveButton.h
//  YiJianDoctor
//
//  Created by YJHou on 15/12/2.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^completionBlock)(BOOL success);


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

@property (nonatomic, copy) completionBlock block;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame andTarget:(SEL)action andID:(id)sender;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame onCompletion:(completionBlock)completionBlock;

-(void)setRippleEffectWithColor:(UIColor *)color;
-(void)setRippeEffectEnabled:(BOOL)setRippeEffectEnabled;

- (void)btnWaveActive;
- (void)setFirstWaveBtn;
- (void)setDownWaveBtn;

@end
