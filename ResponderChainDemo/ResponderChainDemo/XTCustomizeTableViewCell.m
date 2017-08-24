//
//  XTCustomizeTableViewCell.m
//  ResponderChainDemo
//
//  Created by Tong on 2017/8/18.
//  Copyright © 2017年 Tong. All rights reserved.
//

#import "XTCustomizeTableViewCell.h"

#import "UIResponder+Router.h"

NSString * const kXTCustomizeTableViewCellLeftButtonEventNSString = @"kXTCustomizeTableViewCellLeftButtonEventNSString";

NSString * const kXTCustomizeTableViewCellRightButtonEventNSString = @"kXTCustomizeTableViewCellRightButtonEventNSString";

@interface XTCustomizeTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) NSDictionary <NSString *, NSInvocation *> *eventsStrategy;

@end

@implementation XTCustomizeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    [self leftButton];
    
    [self rightButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width  = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.titleLabel.frame = CGRectMake(10, 0, 30, height);
    
    self.leftButton.frame = CGRectMake(50, 0, (width - 40) / 3, height);
    
    self.rightButton.frame = CGRectMake(80 +  (width - 40) / 3, 0, (width - 40) / 3, height);
}

#pragma mark - Event Response

- (void)leftButtonAction
{
    [self routerEventWithName:kXTCustomizeTableViewCellLeftButtonEventNSString userInfo:@{@"leftButton":self.titleLabel.text}];
}

- (void)rightButtonAction
{
    [self routerEventWithName:kXTCustomizeTableViewCellRightButtonEventNSString userInfo:@{@"rightButton":self.titleLabel.text}];
}


- (void)leftButtonEvent:(NSDictionary *)userInfo
{
    NSLog(@"\n\n 不需要让事件继续往上传递 \n eventName:%@ \n userInfo:%@",kXTCustomizeTableViewCellLeftButtonEventNSString, userInfo);
}

- (void)rightButtonEvent:(NSDictionary *)userInfo
{
    /** 可以新增参数传递 */
    NSMutableDictionary *mUserInfo = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [mUserInfo setValue:NSStringFromClass(self.class) forKey:@"eventClass"];
    
    /** 如果需要让事件继续往上传递，则调用下面的语句 */
    [super routerEventWithName:kXTCustomizeTableViewCellRightButtonEventNSString userInfo:mUserInfo];
}


/**
 事件传递方法（不写此方法，则默认全部传递回上一层）
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSInvocation *invocation = self.eventsStrategy[eventName];
    [invocation setArgument:&userInfo atIndex:2];
    [invocation invoke];
    
    /** 如果需要让事件继续往上传递，则调用下面的语句(可在事件中单独加上) */
    // [super routerEventWithName:eventName userInfo:userInfo];
}


#pragma mark - Public Methods

- (void)setCellTitleText:(NSString *)text
{
    self.titleLabel.text = text;
}

#pragma mark - Setter & Getter Methods

- (NSDictionary<NSString *,NSInvocation *> *)eventsStrategy
{
    if (_eventsStrategy == nil) {
        
        _eventsStrategy = @{
                            kXTCustomizeTableViewCellLeftButtonEventNSString  : [self createInvocationWithSelector:@selector(leftButtonEvent:)],
                            kXTCustomizeTableViewCellRightButtonEventNSString : [self createInvocationWithSelector:@selector(rightButtonEvent:)]
                            };
        
    }
    return _eventsStrategy;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"标题";
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)leftButton
{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor redColor];
        [_leftButton setTitle:@"leftButton" forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor blueColor];
        [_rightButton setTitle:@"rightButton" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_rightButton];
    }
    return _rightButton;
}

@end
