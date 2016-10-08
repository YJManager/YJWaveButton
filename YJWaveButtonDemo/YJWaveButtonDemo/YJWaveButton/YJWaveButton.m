//
//  YJWaveButton.m
//  YiJianDoctor
//
//  Created by YJHou on 15/12/2.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import "YJWaveButton.h"
#import <QuartzCore/QuartzCore.h>

@interface YJWaveButton ()

@end

@implementation YJWaveButton



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)commonInitWithImage:(UIImage *)image andFrame:(CGRect) frame{
    
    imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, frame.size.width - 5, frame.size.height - 5);
    imageView.layer.borderColor = [UIColor clearColor].CGColor;
    imageView.layer.borderWidth = 2;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    [self addSubview:imageView];
    
    imageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.9].CGColor;
//    
    gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:gesture];
    
}

-(instancetype)initWithImage:(UIImage *)image
                    andFrame:(CGRect)frame
                   andTarget:(SEL)action
                       andID:(id)sender {
    self = [super initWithFrame:frame];
    
    if(self){
        // 定时器
        [NSTimer scheduledTimerWithTimeInterval:0.001f target:self selector:@selector(btnWaveActive) userInfo:nil repeats:NO];
        self.Ntimer =  [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(btnWaveActive) userInfo:nil repeats:YES];
        [self commonInitWithImage:image andFrame:frame];
        methodName = action;
        superSender = sender;
    }
    
 

    
    return self;
}

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame onCompletion:(completionBlock)completionBlock{
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInitWithImage:image andFrame:frame];
        self.block = completionBlock;
    }
    
    return self;
}


-(void)setRippleEffectWithColor:(UIColor *)color {
    rippleColor = color;
    
}

-(void)setRippeEffectEnabled:(BOOL)enabled {
    isRippleOn = enabled;
}

- (void)btnWaveActive{
    if (isRippleOn) {
        UIColor *stroke = rippleColor ? rippleColor : [UIColor colorWithWhite:0.8 alpha:0.8];
       
        CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
        
        // accounts for left/right offset and contentOffset of scroll view
        CGPoint shapePosition = [self convertPoint:self.center fromView:nil];
        
        CAShapeLayer *circleShape = [CAShapeLayer layer];
        circleShape.path = path.CGPath;
        circleShape.position = shapePosition;
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.opacity = 0;
        circleShape.strokeColor = stroke.CGColor;
        circleShape.lineWidth = 1.5f;
        
        [self.layer addSublayer:circleShape];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @1;
        alphaAnimation.toValue = @0;
        
        CAAnimationGroup *animation = [CAAnimationGroup animation];
        animation.animations = @[scaleAnimation, alphaAnimation];
        animation.duration = 2.5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [circleShape addAnimation:animation forKey:nil];
    }

}

-(void)handleTap:(id)sender{
    
    
    
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
        self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.9].CGColor;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            imageView.alpha = 1;
            self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.9].CGColor;
        }completion:^(BOOL finished) {
            if([superSender respondsToSelector:methodName]){
                [superSender performSelectorOnMainThread:methodName withObject:nil waitUntilDone:NO];
            }
            
            if(_block) {
                BOOL success= YES;
                _block(success);
            }
        }];
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setFirstWaveBtn{
    [self btnWaveActive];
}

- (void)setDownWaveBtn{
    [self.Ntimer invalidate];
    self.Ntimer = nil;
}

-(void)dealloc{
    [self.Ntimer invalidate];
    self.Ntimer = nil;
}

@end
