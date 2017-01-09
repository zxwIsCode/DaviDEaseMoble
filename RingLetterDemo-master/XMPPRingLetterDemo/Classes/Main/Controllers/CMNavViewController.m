//
//  CMNavViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMNavViewController.h"

@interface CMNavViewController ()

@end

@implementation CMNavViewController

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:att];
    
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    itemAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:itemAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        NSString *title = @"返回";
        if (self.childViewControllers.count == 1) {
            title = self.childViewControllers.firstObject.title;
        }
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
