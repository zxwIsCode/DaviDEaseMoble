//
//  CMCommondViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "XLCoversationViewController.h"

@interface XLCoversationViewController ()

@end

@implementation XLCoversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =[UIColor redColor];
    // Do any additional setup after loading the view.
}
#pragma mark - Private Methods
- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == EMConnectionDisconnected) {
//        DDLog(@"网络为链接");
        mAlertView(@"提示", @"网络未链接")
//        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        mAlertView(@"提示", @"网络已链接")
//        self.tableView.tableHeaderView = nil;
    }
}
#pragma mark - 子类继承
-(CMNavType)getNavType {
    return CMNavTypeNone;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
