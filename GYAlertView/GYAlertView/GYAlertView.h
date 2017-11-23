//
//  GYAlertView.h
//  GYAlertView
//
//  Created by gyyang on 2017/11/16.
//  Copyright © 2017年 gyyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYAlertView : UIView

+ (instancetype)sharedInstance;
//+ (void)show;
//+ (void)showInView:(UIView *)view;
//
//+ (void)hide;
- (void)show;
- (void)showInView:(UIView *)view;

- (void)hide;

@end
