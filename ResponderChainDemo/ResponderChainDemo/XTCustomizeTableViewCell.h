//
//  XTCustomizeTableViewCell.h
//  ResponderChainDemo
//
//  Created by Tong on 2017/8/18.
//  Copyright © 2017年 Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kXTCustomizeTableViewCellLeftButtonEventNSString;

extern NSString * const kXTCustomizeTableViewCellRightButtonEventNSString;

@interface XTCustomizeTableViewCell : UITableViewCell

- (void)setCellTitleText:(NSString *)text;

@end
