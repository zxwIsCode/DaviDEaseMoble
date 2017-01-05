//
//  RegisterViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "RegisterViewController.h"
#import "ChatDemoHelper.h"
#import "ToobarHelper.h"

@interface RegisterViewController ()

// 用户名
@property(nonatomic,strong)UITextField *userTextFeild;
// 密码
@property(nonatomic,strong)UITextField *pwdTextFeild;

// 注册的按钮
@property(nonatomic,strong)UIButton *registButton;
// 登录的按钮
@property(nonatomic,strong)UIButton *loginButton;

@end

@implementation RegisterViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.userTextFeild];
    [self.view addSubview:self.pwdTextFeild];
    [self.view addSubview:self.registButton];
    [self.view addSubview:self.loginButton];
    
    // 设置默认账号和密码
    self.userTextFeild.text =@"13715185912";
    self.pwdTextFeild.text =@"qq14725890";
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.userTextFeild.frame =CGRectMake(50, 64 +40, SCREEN_WIDTH - 50 * 2, 30);
    self.pwdTextFeild.frame =CGRectMake(50, CGRectGetMaxY(self.userTextFeild.frame) +10, CGRectGetWidth(self.userTextFeild.frame), 30);
    self.registButton.frame =CGRectMake(30, CGRectGetMaxY(self.pwdTextFeild.frame) +20, 100, 40);
    self.loginButton.frame =CGRectMake(SCREEN_WIDTH -30 -100, CGRectGetMinY(self.registButton.frame) , 100, 40);
}

#pragma mark - Private Methods
-(void)saveLastUserName:(NSString *)nowUserName {
    
    NSString *username = [[EMClient sharedClient] currentUsername];
    if (username ==nil) {
//        [[EMClient sharedClient] currentUsername] =username;
    }
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
        [ud synchronize];
    }
}
#pragma mark - Action Methods

-(void)registerButtonClick:(UIButton *)button {
    if (self.userTextFeild.text.length ==0 || self.pwdTextFeild.text.length ==0) {
        mAlertView(@"提示", @"请输入您要注册的账号和密码");
        return;
    }else {
        [self.view endEditing:YES];
        [self showHudInView:self.view hint:@"正在注册中，请稍后...."];
        WS(ws);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error =[[EMClient sharedClient]registerWithUsername:ws.userTextFeild.text password:ws.pwdTextFeild.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws hideHud];
                if (!error) {
                    mAlertView(@"提示", @"注册成功");
                }else {
                    mAlertView(@"提示", @"注册失败");
                }
            });
        });
    }
}
-(void)loginButtonClick:(UIButton *)button {
    
    [ToobarHelper choseAllRootViewControllersisTabBar:YES andWindow:self.view.window];
    return;
    
    if (self.userTextFeild.text.length == 0 || self.pwdTextFeild.text.length ==0) {
        mAlertView(@"提示", @"请输入您要注册的账号和密码");
        return;
    }else {
        [self.view endEditing:YES];
        [self showHudInView:self.view hint:@"正在登录中，请稍后...."];
        WS(ws);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = [[EMClient sharedClient] loginWithUsername:self.userTextFeild.text password:self.pwdTextFeild.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws hideHud];
                if (!error) {
                    // 设置是否自动登录（暂时不可以）
                    [[EMClient sharedClient].options setIsAutoLogin:NO];
                    [MBProgressHUD showHUDAddedTo:ws.view animated:YES];
                    
                    //获取数据库（数据迁移完毕才可以获得）
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [[EMClient sharedClient]migrateDatabaseToLatestSDK];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 获得所有的群组列表
                            [[ChatDemoHelper shareHelper] asyncGroupFromServer];
                            // 获得所有的会话列表
                            [[ChatDemoHelper shareHelper] asyncConversationFromDB];

//                            // 获得推送属性暂不用
//                            [[ChatDemoHelper shareHelper] asyncPushOptions];
                            [MBProgressHUD hideAllHUDsForView:ws.view animated:YES];
                            
                            [ws saveLastUserName:self.userTextFeild.text];
                        });
                    });
                }
            });
 
        });

        
    }
}
#pragma mark - Delegate
#pragma mark - Setter & Getter
-(UITextField *)userTextFeild {
    if (!_userTextFeild) {
        _userTextFeild =[[UITextField alloc]init];
        _userTextFeild.placeholder =@"个人账号/手机";
        _userTextFeild.keyboardType =UIKeyboardTypeNumberPad;
        _userTextFeild.borderStyle =UITextBorderStyleRoundedRect;
//        _userTextFeild.backgroundColor =[UIColor redColor];
    }
    return _userTextFeild;
}

-(UITextField *)pwdTextFeild {
    if (!_pwdTextFeild) {
        _pwdTextFeild =[[UITextField alloc]init];
        _pwdTextFeild.placeholder =@"密码";
        _pwdTextFeild.borderStyle =UITextBorderStyleRoundedRect;
        _pwdTextFeild.secureTextEntry = YES;
//        _pwdTextFeild.backgroundColor =[UIColor redColor];
    }
    return _pwdTextFeild;
}

-(UIButton *)registButton {
    if (!_registButton) {
        _registButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _registButton.backgroundColor =[UIColor blueColor];
        [_registButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registButton;
}

-(UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor =[UIColor blueColor];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
