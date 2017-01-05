//
//  MainViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "MainViewController.h"

#import "ConversationViewController.h"
#import "ContactViewController.h"
#import "SettingViewController.h"
#import "NavBaseViewController.h"

@interface MainViewController ()

// 联系人
@property(nonatomic,strong)ContactViewController *contactVC;
// 会话
@property(nonatomic,strong)ConversationViewController *conversationVC;
// 设置
@property(nonatomic,strong)SettingViewController *settingVC;

@end

@implementation MainViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    // 设置tabar的背景颜色
    [self setupTabBarBackground];
    
    //把ChatDemoHelper 的各个VC赋值对应的VC
    [ChatDemoHelper shareHelper].contactViewVC =self.contactVC;
    [ChatDemoHelper shareHelper].contactViewVC =self.conversationVC;
//    [ChatDemoHelper shareHelper].
    
    // Do any additional setup after loading the view.
}
-(void)test {
    //  1 和2 证明数字短的话，long和int没区别
    long dataid1 =4;
    NSMutableArray *array1 =[NSMutableArray array];
    [array1 addObject:@(dataid1)];
    
    NSLog(@"array = %@",array1);
    
    long dataId2 =3237873939;
    NSMutableArray *array2 =[NSMutableArray array];
    [array2 addObject:@(dataId2)];
    NSLog(@" array2222 =%@",array2);
    
    long dataId3 =23423;
    NSMutableArray *array3 =[NSMutableArray array];
    [array3 addObject:[NSNumber numberWithLong:dataId3]];
    NSLog(@"array333333 =%@",array3);
}

#pragma mark - Private Methods

-(void)setupTabBarBackground {
    
    self.tabBar.accessibilityIdentifier = @"tabbar";
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.会话
    [self setupChildViewController:self.conversationVC title:@"会话" imageName:@"tabbar_chats" selectedImageName:@"tabbar_chatsHL"];
    
    // 2.联系人
    [self setupChildViewController:self.contactVC title:@"联系人" imageName:@"tabbar_contacts" selectedImageName:@"tabbar_contactsHL"];
    
    // 3.设置
    [self setupChildViewController:self.settingVC title:@"设置" imageName:@"tabbar_setting" selectedImageName:@"tabbar_settingHL"];
 
}

/**
 *  初始化一个子控制器

 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    NavBaseViewController *nav = [[NavBaseViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


#pragma mark - Setter & Getter
-(ConversationViewController *)conversationVC {
    if (!_conversationVC) {
        _conversationVC =[[ConversationViewController alloc]init];
        _conversationVC.view.backgroundColor =[UIColor redColor];
    }
    return _conversationVC;
}
-(ContactViewController *)contactVC {
    if (!_contactVC) {
        _contactVC =[[ContactViewController alloc]init];
        _contactVC.view.backgroundColor =[UIColor blueColor];
       
    }
    return _contactVC;
}
-(SettingViewController *)settingVC {
    if (!_settingVC) {
        _settingVC =[[SettingViewController alloc]init];
        _settingVC.view.backgroundColor =[UIColor yellowColor];

    }
    return _settingVC;
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
