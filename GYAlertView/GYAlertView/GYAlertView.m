//
//  GYAlertView.m
//  GYAlertView
//
//  Created by gyyang on 2017/11/16.
//  Copyright © 2017年 gyyang. All rights reserved.
//

#import "GYAlertView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface GYAlertView ()

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *headerLabel;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *contentLabel;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSArray<NSString *> *btnArray;

@property (nonatomic, assign) CGFloat coverWidth;

@end

@implementation GYAlertView

#pragma mark - life Cycle

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.coverWidth = kScreenWidth *0.8;
        self.btnArray = @[@"确定",@"取消"];
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.frame = [UIScreen mainScreen].bounds;
    
    [self addSubview:self.coverView];
    
    [_coverView addSubview:self.headerView];
    [_coverView addSubview:self.contentView];
    [_coverView addSubview:self.footerView];
    
}

- (void)registerNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector() name:UIApplicationDidReceiveMemoryWarningNotification object:nil];//收到内存警告，释放
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat coverWidth = kScreenWidth *0.8;
    CGFloat coverHeight = kScreenWidth *0.8;
    _coverView.frame = CGRectMake((kScreenWidth-coverWidth)*0.5, (kScreenHeight-coverHeight)*0.5, coverWidth, coverHeight);
    
    _headerView.frame = CGRectMake(0, 0, coverWidth, coverHeight *0.3);
    _contentView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), coverWidth, coverHeight *0.4);
    _footerView.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame), coverWidth, coverHeight *0.3);
    
//    _headerLabel.frame = _headerView.frame;
//    _contentLabel.frame = _contentView.frame;
    _headerLabel.frame = _headerView.bounds;
    _contentLabel.frame = _contentView.bounds;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

//#pragma mark - Show Method
//+ (void)show {
//    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//
//    } completion:^(BOOL finished) {
//
//    }];
//}
//
//#pragma mark - Hide Method
//+ (void)hide {
//    [[GYAlertView sharedInstance] hide];
//}

- (void)show {
    [self showInView:nil];
}

- (void)showInView:(UIView *)view {
    
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    [view addSubview:[GYAlertView sharedInstance]];
    
    _coverView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    _coverView.alpha = 0;
    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _coverView.transform = CGAffineTransformIdentity;
        _coverView.alpha = 1;
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _coverView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        _coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Lazy load
- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
        _coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _coverView.layer.cornerRadius = 10;
        _coverView.layer.masksToBounds = YES;
        //背景，圆角，渐变
    }
    return _coverView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        
        _headerLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16];
            label.numberOfLines = 0;
            label.text = @"占位文字";
            
            label;
        });
        
        [_headerView addSubview:_headerLabel];
    }
    return _headerView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        
        _contentLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16];
            label.numberOfLines = 0;
            label.text = @"占位文字";
            
            label;
        });
        
        [_contentView addSubview:_contentLabel];
    }
    return _contentView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
    }
    return _footerView;
}

- (void)setBtnArray:(NSArray<NSString *> *)btnArray {
    if (btnArray.count<=0) {
        return;
    }
    
    _btnArray = btnArray;
    
    CGFloat btnWidth = self.coverWidth / btnArray.count;
    for (int i = 0;i<btnArray.count;i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.coverWidth*0.3);
//        [btn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:btnArray[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        [self.footerView addSubview:btn];
    }
}




@end
