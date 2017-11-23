//
//  ViewController.m
//  GYAlertView
//
//  Created by gyyang on 2017/11/16.
//  Copyright © 2017年 gyyang. All rights reserved.
//

#import "ViewController.h"
#import "GYAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan:");
    [[GYAlertView sharedInstance] showInView:self.view];
}

@end
