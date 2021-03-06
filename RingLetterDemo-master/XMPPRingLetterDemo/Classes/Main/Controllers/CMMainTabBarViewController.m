//
//  CMMainTabBarViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMMainTabBarViewController.h"
#import "CMNavViewController.h"
#import "XLAddressViewController.h"
#import "XLCoversationViewController.h"
#import "XLDiscoverViewController.h"
#import "XLSettingViewController.h"

#import "CMCustomTabBar.h"

@interface CMMainTabBarViewController ()<CMCustomTabBarDelegate>

@property(nonatomic,strong)XLCoversationViewController *coversationVC;

@property(nonatomic,strong)XLAddressViewController *addressVC;

@property(nonatomic,strong)XLDiscoverViewController *discoverVC;

@property(nonatomic,strong)XLSettingViewController *settingVC;

@property(nonatomic,strong)CMCustomTabBar *customTabBar;

@end

@implementation CMMainTabBarViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupCustomTabBar];
    
    [self setupAllChildViewControllers];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark - Private Methods


-(void)setupCustomTabBar {
    CMCustomTabBar *customTabBar =[[CMCustomTabBar alloc]init];
    CGFloat tabBarHeight =84 *kAppScale;
    customTabBar.frame =CGRectMake(0, 49.0 -tabBarHeight, SCREEN_WIDTH, tabBarHeight);
    [self.tabBar addSubview:customTabBar];
    self.customTabBar =customTabBar;
    self.customTabBar.delegate =self;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.会话
    [self setupChildViewController:self.coversationVC title:@"会话" imageName:@"icon_shouye" selectedImageName:@"icon_shouyebian" andIndex:0];
    
    // 2.通讯录
    [self setupChildViewController:self.addressVC title:@"通讯录" imageName:@"icon_renwu" selectedImageName:@"icon_renwubian" andIndex:1];
    
    // 3.发现
    [self setupChildViewController:self.discoverVC title:@"发现" imageName:@"icon_erweima" selectedImageName:@"icon_erweimabian" andIndex:2];
    
    // 4.设置
    [self setupChildViewController:self.settingVC title:@"设置" imageName:@"icon_yonghu" selectedImageName:@"icon_yonghubian" andIndex:3];
    
}

/**
 *  初始化一个子控制器
 
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName andIndex:(NSInteger)index
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];

    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    CMNavViewController *nav = [[CMNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 自定义TabBar的SubViews
    [self.customTabBar creatAllTabBarSubViews:childVc.tabBarItem andIndex:index];
    
    
}

// 网络状态变化
- (void)networkChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    [self.coversationVC networkChanged:_connectionState];
}
#pragma mark - CMCustomTabBarDelegate

-(void)tabBar:(CMCustomTabBar *)tabBar didSelectVC:(NSInteger)lastIndex andNext:(NSInteger)nextIndex {
    self.selectedIndex =nextIndex -kTabBarButtonBaseTag;
}

#pragma mark - Setter & Getter
-(XLCoversationViewController *)coversationVC {
    if (!_coversationVC) {
        _coversationVC =[[XLCoversationViewController alloc]init];

    }
    return _coversationVC;
}

-(XLAddressViewController *)addressVC {
    if (!_addressVC) {
        _addressVC =[[XLAddressViewController alloc]init];
    }
    return _addressVC;
}

-(XLDiscoverViewController *)discoverVC {
    if (!_discoverVC) {
        _discoverVC =[[XLDiscoverViewController alloc]init];
    }
    return _discoverVC;
}
-(XLSettingViewController *)settingVC {
    if (!_settingVC) {
        _settingVC =[[XLSettingViewController alloc]init];
    }
    return _settingVC;
}

@end
