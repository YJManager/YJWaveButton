//
//  ViewController.m
//  YJWaveButtonDemo
//
//  Created by YJHou on 2016/10/8.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "ViewController.h"
#import "YJWaveButton.h"

@interface ViewController ()

@property (nonatomic, strong) YJWaveButton *waveButton; /**< 按钮 */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.waveButton];
    [self.waveButton btnWaveActive];
}


#pragma mark - Lazy
- (YJWaveButton *)waveButton{
    if (!_waveButton) {
        _waveButton = [[YJWaveButton alloc] initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width - 200, [UIScreen mainScreen].bounds.size.width - 200) image:[UIImage imageNamed:@"button"] completion:^(BOOL success) {
            NSLog(@"-->%d", success);
        }];
        [_waveButton setRippeEffectEnabled:YES];
        [_waveButton setRippleEffectWithColor:[UIColor redColor]];
    }
    return _waveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
