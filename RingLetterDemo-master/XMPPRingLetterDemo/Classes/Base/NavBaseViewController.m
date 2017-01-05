//
//  NavBaseViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "NavBaseViewController.h"

@interface NavBaseViewController ()

@end

@implementation NavBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaviBar];
    // Do any additional setup after loading the view.
}

-(void )initNaviBar{
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // 去除黑线
    [navigationBar setBackgroundImage:[[UIImage alloc] init]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor blueColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
