//
//  ViewController.m
//  ResponderChainDemo
//
//  Created by Tong on 2017/8/18.
//  Copyright © 2017年 Tong. All rights reserved.
//

#import "ViewController.h"

#import "XTCustomizeTableViewCell.h"

#import "UIResponder+Router.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - --------------------------- Init And Dealloc ---------------------------


#pragma mark - --------------------------- Life Cycle ---------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self tableView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20);
}


#pragma mark - --------------------------- Data Request ---------------------------


#pragma mark - --------------------------- Event Response ---------------------------


#pragma mark - --------------------------- Delegate Response ---------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cellReuseIdentifier";
    XTCustomizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[XTCustomizeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setCellTitleText:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - --------------------------- NSNotification Response ---------------------------


#pragma mark - --------------------------- Public Events ---------------------------

/**
 事件处理
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSLog(@"\n\n class:%@ \n eventName:%@ \n userInfo:%@\n\n", NSStringFromClass(self.class), eventName, userInfo);
    
    // 可以创建 EventProxy 对象，专门处理 Responder Chain 上传递的事件。
    // [self.eventProxy handleEvent:eventName userInfo:userInfo];
}

#pragma mark - --------------------------- Private Events ---------------------------


#pragma mark - --------------------------- Setter and Getter---------------------------

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = [[UIView alloc] init];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
